require 'rails_helper'

RSpec.describe BookBorrowService do
  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }
  describe "#borrow" do
    it "borrows a book from library successfully if book is available" do
      Timecop.freeze(Time.zone.now)

      result = BookBorrowService.borrow(user: user, book: book)

      expect(result).to eq(true)
      expect(book.inventory.reload.current_quantity).to be_zero
      expect(transaction.borrowed_at).to eq(Time.zone.now)
      expect(transaction.returned_at).to be_nil
    end

    it "doesn't borrow a book from library successfully if book is not available" do
      inventory = book.inventory
      inventory.update_attributes(current_quantity: 0)
      BookBorrowService.borrow(user: user, book: book)

      expect(inventory.reload.current_quantity).to be_zero
      expect(transaction).to be_nil
    end
  end

  def transaction
    @transaction ||= Transaction.find_by(user: user, book: book)
  end
end