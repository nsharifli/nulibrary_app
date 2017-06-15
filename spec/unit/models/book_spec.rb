require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { FactoryGirl.build_stubbed(:book) }
  let(:user) { FactoryGirl.build_stubbed(:user) }

  describe "#in_stock" do
    it "is true when inventory for book is greater than zero" do
      allow(Inventory).to receive(:current_quantity).and_return(1)

      in_stock = book.in_stock?

      expect(in_stock).to eq(true)
    end

    it "is false when inventory for book is zero" do
      allow(Inventory).to receive(:current_quantity).and_return(0)

      in_stock = book.in_stock?

      expect(in_stock).to eq(false)
    end
  end

  describe "#borrow" do
    it "reduces inventory for this book by one" do
      expect(Inventory).to receive(:borrow)
      expect(Transaction).to receive(:add_borrow_entry)

      book.borrow(user)
    end

    it "adds new entry to transactions table" do
      allow(Inventory).to receive(:borrow).and_return(true)

      expect(Transaction).to receive(:add_borrow_entry)

      book.borrow(user)
    end
  end

  describe "#current_quantity" do
    it "returns current quantity of the book" do
      expect(Inventory).to receive(:current_quantity)

      book.current_quantity
    end
  end

  describe "#total_quantity" do
    it "returns total quantity of the book" do
      expect(Inventory).to receive(:total_quantity)

      book.total_quantity
    end
  end

  describe "#return" do
    it "increases inventory for this book by one" do
      allow(Transaction).to receive(:update_book_transaction).and_return(true)

      expect(Inventory).to receive(:return)

      book.return(user)
    end

    it "updates corresponding entry in transactions table" do
      allow(Inventory).to receive(:return).and_return(true)

      expect(Transaction).to receive(:update_book_transaction)

      book.return(user)
    end
  end
end