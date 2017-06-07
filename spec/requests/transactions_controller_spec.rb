require 'rails_helper'

RSpec.describe TransactionsController, type: :request do
  describe "GET transactionss#index" do
    it "index page returns list of books user checked out if user is signed in" do
      book_1 = FactoryGirl.create(:book, title: "Book1")
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:transaction, :unreturned, book: book_1, user: user)

      sign_in user

      get transactions_path

      expect(response.body).to include(book_1.title)
      expect(response.body).to include("Return")
    end

    it "index page responds with 403 if user is not signed in" do
      get transactions_path

      expect(response.status).to eq(403)
    end
  end


end
