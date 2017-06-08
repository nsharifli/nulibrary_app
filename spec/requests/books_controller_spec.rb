require 'rails_helper'

RSpec.describe BooksController, type: :request do
  describe "GET books#index" do
    it "index page returns list of books" do
      FactoryGirl.create(:book, title: "Book1")
      FactoryGirl.create(:book, title: "Book2")

      get books_path

      expect(response.body).to include('Book1')
      expect(response.body).to include('Book2')
    end
  end

  describe "GET books#show" do
    it "show page returns details of book" do
      book_1 = FactoryGirl.create(:book, title: "Book1")

      get book_path(book_1.id)

      expect(response.body).to include('Book1')
    end
  end

  describe "GET books#borrow" do
    it "borrows a book" do
      book_1 = FactoryGirl.create(:book, title: "Book1")
      FactoryGirl.create(:user, email: "example@gmail.com")

      post borrow_book_path(book_1.id)

      expect(response.body).to include "Successfully borrowed"
    end
  end

  describe "PUT books#return" do
    it "returns a book" do
      book_1 = FactoryGirl.create(:book, title: "Book1")
      user_1 = FactoryGirl.create(:user, email: "example@gmail.com")
      FactoryGirl.create(:transaction, :unreturned, user: user_1, book: book_1)
      sign_in user_1

      put return_book_path(book_1.id)

      expect(response).to redirect_to(transactions_path)
      follow_redirect!
      expect(response.body).to include "Successfully returned #{book_1.title}"
    end
  end
end
