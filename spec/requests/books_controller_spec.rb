require 'rails_helper'

RSpec.describe BooksController, type: :request do
  let(:book_1) { FactoryGirl.create(:book)}

  describe "GET books#index" do
    it "index page returns list of books" do
      book_2 = FactoryGirl.create(:book)
      get books_path

      expect(response.body).to include(book_1.title)
      expect(response.body).to include(book_2.title)
    end
  end

  describe "GET books#show" do
    it "show page returns details of book" do
      get book_path(book_1.id)

      expect(response.body).to include(book_1.title)
    end
  end

  describe "GET books#borrow" do
    it "cannot borrow a book if user is not logged in" do
      post borrow_book_path(book_1.id)

      expect(response).to redirect_to(new_user_session_path)
      follow_redirect!
      expect(response.body).to include "Please log in to borrow a book"
    end

    it "succesfully borrows a book when user is logged in and redirects to books index page" do
      user = FactoryGirl.create(:user)
      sign_in user
      post borrow_book_path(book_1.id)

      expect(response).to redirect_to(books_path)
      follow_redirect!
      expect(response.body).to include "Successfully borrowed"
    end

    it "returns an error message when there is no inventory" do
      user = FactoryGirl.create(:user)

      sign_in user
      post borrow_book_path(book_1.id)
      post borrow_book_path(book_1.id)

      expect(response).to redirect_to(books_path)
      follow_redirect!
      expect(response.body).to include("Book is not available anymore")
    end
  end

  describe "PUT books#return" do
    it "returns a book" do
      user_1 = FactoryGirl.create(:user, email: "example@gmail.com")
      FactoryGirl.create(:transaction, :unreturned, user: user_1, book: book_1)
      book_1.inventory.current_quantity = 0
      book_1.inventory.save
      sign_in user_1

      put return_book_path(book_1.id)

      expect(response).to redirect_to(transactions_path)
      follow_redirect!
      expect(response.body).to include "Successfully returned #{book_1.title}"
    end

    it "provides an error when returning a book that is already returned" do
      user_1 = FactoryGirl.create(:user, email: "example@gmail.com")
      FactoryGirl.create(:transaction, user: user_1, book: book_1)
      sign_in user_1

      put return_book_path(book_1.id)
      expect(response).to redirect_to(transactions_path)
      follow_redirect!
      expect(response.body).to include "Already returned the book"
    end
  end

  describe "GET books#hold" do
    it "cannot place a hold for a book if user is not logged in" do
      post hold_book_path(book_1.id)
      expect(response).to redirect_to(book_path(book_1.id))
      follow_redirect!
      expect(response.body).to include "Please log in to place a hold for a book"
    end

    it "succesfully places a hold for a book when user is logged in" do
      user = FactoryGirl.create(:user)
      sign_in user
      post hold_book_path(book_1.id)

      expect(response).to redirect_to(book_path(book_1.id))
      follow_redirect!
      expect(response.body).to include "Successfully placed a hold for #{book_1.title}"
    end
  end

  describe "GET books#new" do
    it "displays a new book form" do
      admin = FactoryGirl.create(:user, admin: true)

      sign_in admin

      get new_book_path

      expect(response.body).to have_selector("#book_isbn")
      expect(response.body).to have_selector("#inventory_quantity")
    end

    it "redirects to root page if user is not admin" do
      user = FactoryGirl.create(:user)

      sign_in user

      get new_book_path

      expect(response).to redirect_to root_path
    end
  end

  describe "POST books#create" do
    it "creates a new book and corresponding inventory" do
      admin = FactoryGirl.create(:user, admin: true)

      sign_in admin
      allow(GoogleBooksAdapter).to receive(:find_title).with("1234567854").and_return("Book title")

      params = { "book"=>{"isbn"=>"1234567854"}, "inventory"=>{"quantity"=>"2"} }
      post books_path, params: params

      expect(response).to redirect_to(books_path)
      follow_redirect!
      expect(response.body).to include("Book title")
    end

    it "if book is not found it goes back to new book path" do
      admin = FactoryGirl.create(:user, admin: true)

      sign_in admin
      allow(GoogleBooksAdapter).to receive(:find_title).with("1234567854").and_return(nil)

      params = { "book"=>{"isbn"=>"1234567854"}, "inventory"=>{"quantity"=>"2"} }
      post books_path, params: params

      expect(response).to redirect_to(new_book_path)
      follow_redirect!
      expect(response.body).to include("Book is not found")
    end
  end

  describe "books#destroy" do
    it "deletes book successfully if book is not checked out by anyone" do
      admin = FactoryGirl.create(:user, admin: true)
      book = FactoryGirl.create(:book)

      sign_in admin

      expect do
        delete book_path(book.id)
      end.to change { Book.count }.by(-1).and change { Inventory.count }.by(-1)

      follow_redirect!
      expect(response.body).to include "Successfully deleted #{book.title}"
    end

    it "doesn't delete book if it is checked out" do
      admin = FactoryGirl.create(:user, admin: true)
      book = FactoryGirl.create(:book)
      FactoryGirl.create(:transaction, user: admin, book: book)

      sign_in admin

      expect do
        delete book_path(book.id)
      end.not_to change { Book.count }

      follow_redirect!
      expect(response.body).to include "Cannot delete #{book.title} since it is checked out"
    end

    it "provides an error if book is already deleted" do
      admin = FactoryGirl.create(:user, admin: true)
      book = FactoryGirl.create(:book)

      sign_in admin
      delete book_path(book.id)

      expect do
        delete book_path(book.id)
      end.not_to change { Book.count }

      follow_redirect!
      expect(response.body).to include "Book has already been deleted"
    end
  end
end
