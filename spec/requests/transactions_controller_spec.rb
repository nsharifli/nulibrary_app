require 'rails_helper'

RSpec.describe TransactionsController, type: :request do
  describe "GET transactionss#index" do
    it "index page returns list of books user checked out" do
      book_1 = FactoryGirl.create(:book, title: "Book1")
      FactoryGirl.create(:book, title: "Book2")
      user = FactoryGirl.create(:user)

      sign_in user

      get transactions_path

      expect(response.body).to include(book_1.title)
      expect(response.body).to include("Return")
    end
  end
end
