require 'rails_helper'

RSpec.describe BooksController, type: :request do
  let(:book_1) { FactoryGirl.create(:book)}
  let(:book_2) { FactoryGirl.create(:book)}

  describe "GET books#index" do
    it "index page returns list of books" do
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
    it "borrows a book" do
      post borrow_book_path(book_1.id)

      expect(response.body).to include "Successfully borrowed"
    end

    it "returns an error message when there is no inventory" do
      user = FactoryGirl.create(:user)

      sign_in user
      post borrow_book_path(book_1.id)
      post borrow_book_path(book_1.id)

      expect(response.body).to include("Current quantity must be greater than or equal to 0")
    end
  end

  describe "PUT books#return" do
    it "returns a book" do
      user_1 = FactoryGirl.create(:user, email: "example@gmail.com")
      FactoryGirl.create(:transaction, :unreturned, user: user_1, book: book_1)
      sign_in user_1

      put return_book_path(book_1.id)

      expect(response).to redirect_to(transactions_path)
      follow_redirect!
      expect(response.body).to include "Successfully returned #{book_1.title}"
    end

    it "returns a book that is already returned" do
      user_1 = FactoryGirl.create(:user, email: "example@gmail.com")
      FactoryGirl.create(:transaction, user: user_1, book: book_1)
      sign_in user_1

      put return_book_path(book_1.id)
      expect(response).to redirect_to(transactions_path)
      follow_redirect!
      expect(response.body).to include "Already returned the book"
    end
  end

  describe "GET books#new" do
    it "displays a new book form" do
      admin = FactoryGirl.create(:user, admin: true)

      sign_in admin

      get new_book_path

      expect(response.body).to have_selector("#book_ibn")
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

      params = { "book"=>{"ibn"=>"1234567854"}, "inventory"=>{"quantity"=>"2"} }
      post books_path, params: params

      expect(response).to redirect_to(books_path)
      follow_redirect!
      expect(response.body).to include("Book title")
    end

    it "if book is not found it goes back to new book path" do
      admin = FactoryGirl.create(:user, admin: true)

      sign_in admin
      allow(GoogleBooksAdapter).to receive(:find_title).with("1234567854").and_return(nil)

      params = { "book"=>{"ibn"=>"1234567854"}, "inventory"=>{"quantity"=>"2"} }
      post books_path, params: params

      expect(response).to redirect_to(new_book_path)
      follow_redirect!
      expect(response.body).to include("Book is not found")
    end
  end
end
