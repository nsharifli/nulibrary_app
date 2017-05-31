require 'rails_helper'


RSpec.describe BooksController, type: :request do
  describe "GET #index" do
    it "returns list of books" do
      book_1 = FactoryGirl.create(:book, ibn: "1", title: "Book1")
      book_2 = FactoryGirl.create(:book, ibn: "2", title: "Book2")

      get books_path

      expect(response.body).to include('Book1')
      expect(response.body).to include('Book2')
    end
  end
end
