require 'rails_helper'

RSpec.describe BookReturnService do
  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }
  describe "#return" do
    it "returns book successfully if book is borrowed and not returned" do
      inventory = book.inventory
      inventory.update_attributes(current_quantity: 0)
      transaction = FactoryGirl.create(:transaction, :unreturned, book: book, user: user)
      Timecop.freeze(Time.zone.now)

      result = BookReturnService.return(book: book, user: user)

      expect(result).to eq(true)
      expect(transaction.reload.returned_at).to eq(Time.zone.now)
      expect(inventory.reload.current_quantity).to eq(1)
    end

    it "doesn't return book successfully if current quantity is equal to total quantity" do
      transaction = FactoryGirl.create(:transaction, :unreturned, book: book, user: user)
      inventory = book.inventory

      BookReturnService.return(book: book, user: user)

      expect(transaction.reload.returned_at).to be_nil
      expect(inventory.reload.current_quantity).to eq(1)
    end

    it "doesn't return book successfully if book is already returned by user" do
      inventory = book.inventory
      inventory.update_attributes(current_quantity: 0)
      return_time = Time.zone.parse('2017-06-13T10:00:00-05:00')
      transaction = FactoryGirl.create(:transaction, book: book, user: user, returned_at: return_time)

      BookReturnService.return(book: book, user: user)

      expect(inventory.reload.current_quantity).to eq(0)
      expect(transaction.reload.returned_at).to eq(return_time)
    end
  end

end