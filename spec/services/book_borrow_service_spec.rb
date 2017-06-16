require 'rails_helper'

RSpec.describe BookBorrowService, type: :unit do
  let(:book) { FactoryGirl.build_stubbed(:book) }
  let(:user) { FactoryGirl.build_stubbed(:user) }
  describe "#borrow" do
    it "borrows a book from library successfully if book is available" do
      allow(BookBorrowService).to receive(:decrease_inventory).with(book.id).and_return(true)
      allow(BookBorrowService).to receive(:add_borrow_entry).with(user, book.id).and_return(true)

      result = BookBorrowService.borrow(user: user, book: book)

      expect(result).to eq(true)
    end

    it "doesn't borrow a book from library successfully if book is not available" do
      allow(BookBorrowService).to receive(:decrease_inventory).with(book.id).and_raise("ValidationError")
      allow(BookBorrowService).to receive(:add_borrow_entry).and_return(true)

      expect{ BookBorrowService.borrow(user: user, book: book) }.to raise_error("ValidationError")
    end

    it "doesn't borrow a book from library successfully if book is already returned" do
      allow(BookBorrowService).to receive(:decrease_inventory).with(book.id).and_return(true)
      allow(BookBorrowService).to receive(:add_borrow_entry).and_raise("ValidationError")

      expect{ BookBorrowService.borrow(user: user, book: book) }.to raise_error("ValidationError")
    end
  end
end