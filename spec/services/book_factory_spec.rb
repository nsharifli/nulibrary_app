require 'rails_helper'

RSpec.describe BookFactory, type: :unit do
  describe "#create" do
    it "returns false if book is not found" do
      isbn = "1234567890"
      allow(GoogleBooksAdapter).to receive(:find_title).with(isbn).and_return(nil)

      result = BookFactory.create(isbn: isbn, quantity: 2)

      expect(result).to eq(false)
    end

    it "returns false if quantity is less than zero" do
      isbn = "1234567890"
      quantity = -2
      allow(GoogleBooksAdapter).to receive(:find_title).with(isbn).and_return("Book title")

      result = BookFactory.create(isbn: isbn, quantity: quantity)

      expect(result).to eq(false)
    end
  end

end