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
      user = FactoryGirl.build_stubbed(:user)
      expect(Inventory).to receive(:borrow)

      book.borrow(user)
    end

    it "adds new entry to transactions table" do
      book = FactoryGirl.build_stubbed(:book)
      user = FactoryGirl.build_stubbed(:user)
      allow(Inventory).to receive(:borrow).and_return(true)

      expect(Transaction).to receive(:add_borrow_entry)

      book.borrow(user)
    end
  end

  describe "#current_quantity" do
    it "returns current quantity of the book" do
      book = FactoryGirl.build_stubbed(:book)
      expect(Inventory).to receive(:current_quantity)

      book.current_quantity
    end
  end

  describe "#total_quantity" do
    it "returns total quantity of the book" do
      book = FactoryGirl.build_stubbed(:book)

      expect(Inventory).to receive(:total_quantity)

      book.total_quantity
    end
  end

  describe "#return" do
    it "increases inventory for this book by one" do
      book = FactoryGirl.build_stubbed(:book)
      user = FactoryGirl.build_stubbed(:user)

      expect(Inventory).to receive(:return)

      book.return(user)
    end

    it "updates corresponding entry in transactions table" do
      book = FactoryGirl.build_stubbed(:book)
      user = FactoryGirl.build_stubbed(:user)
      allow(Inventory).to receive(:return).and_return(true)

      expect(Transaction).to receive(:update_book_transaction)

      book.return(user)
    end
  end
end