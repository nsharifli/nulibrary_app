require 'rails_helper'

RSpec.describe BookBorrowService, type: :unit do
  let(:book) { FactoryGirl.build_stubbed(:book) }
  let(:user) { FactoryGirl.build_stubbed(:user) }
  describe "#borrow" do
    it "borrows a book from library successfully if book is available" do
      allow(Inventory).to receive(:borrow).with(book.id).and_return(true)
      allow(Transaction).to receive(:add_borrow_entry).and_return(true)

      result = BookBorrowService.borrow(user: user, book: book)

      expect(result).to eq(true)
    end
  end
end