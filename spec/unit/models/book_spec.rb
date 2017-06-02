require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "#in_stock" do
    it "is true when inventory for book is greater than zero" do
      book = FactoryGirl.build_stubbed(:book)
      allow(Inventory).to receive(:current_quantity).and_return(1)

      in_stock = book.in_stock?

      expect(in_stock).to eq(true)
    end

    it "is false when inventory for book is zero" do
      book = FactoryGirl.build_stubbed(:book)
      allow(Inventory).to receive(:current_quantity).and_return(0)

      in_stock = book.in_stock?

      expect(in_stock).to eq(false)
    end
  end

  describe "#borrow" do
    it "reduces inventory for this book by one" do
      book = FactoryGirl.build_stubbed(:book)
      expect(Inventory).to receive(:borrow)

      book.borrow
    end
  end

  describe "#current_quantity" do
    it "returns current quantity of the book" do
      book = FactoryGirl.build_stubbed(:book)
      expect(Inventory).to receive(:current_quantity)

      book.current_quantity
    end
  end
end