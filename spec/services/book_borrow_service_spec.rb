require 'rails_helper'

RSpec.describe BookBorrowService do
  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }
  describe "#borrow" do
    it "borrows a book from library successfully if book is available" do

      result = BookBorrowService.borrow(user: user, book: book)

      expect(result).to eq(true)
      expect(book.inventory.reload.current_quantity).to eq(0)
      expect(Transaction.find_by(user: user, book_id: book.id).borrowed_at).not_to eq(nil)
      expect(Transaction.find_by(user: user, book_id: book.id).returned_at).to eq(nil)
    end

    it "doesn't borrow a book from library successfully if book is not available" do
      inventory = book.inventory
      inventory.update_attributes(current_quantity: 0)
      BookBorrowService.borrow(user: user, book: book)

      expect(inventory.reload.current_quantity).to eq(0)
      expect(Transaction.find_by(user: user, book_id: book.id)).to eq(nil)
    end

    it "doesn't borrow a book from library successfully if book is already returned" do
      allow(BookBorrowService).to receive(:decrease_inventory).with(book.id).and_return(true)
      allow(BookBorrowService).to receive(:add_borrow_entry).and_raise("ValidationError")

      expect{ BookBorrowService.borrow(user: user, book: book) }.to raise_error("ValidationError")
    end
  end
end