require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "#currently_reading_users" do
    it "returns users who currently have that book" do
      book_1 = FactoryGirl.create(:book)
      user_1 = FactoryGirl.create(:user)
      user_2 = FactoryGirl.create(:user, email: 'user2@test.com')
      transaction_1 = FactoryGirl.create(:transaction, :unreturned, book: book_1, user: user_1, borrowed_at: '2016-12-31 14:00:00')
      transaction_2 = FactoryGirl.create(:transaction, :unreturned, book: book_1, user: user_1, borrowed_at: '2016-12-31 15:00:00')
      transaction_3 = FactoryGirl.create(:transaction, :unreturned, book: book_1, user: user_2, borrowed_at: '2016-12-31 16:00:00')

      transactions = Transaction.currently_reading_users(book: book_1)

      expect(transactions.where(user_id: user_1.id).count).to eq(2)
      expect(transactions.where(user_id: user_2.id).count).to eq(1)
      expect(transactions.where(borrowed_at: transaction_1.borrowed_at).count).to eq(1)
      expect(transactions.where(borrowed_at: transaction_2.borrowed_at).count).to eq(1)
      expect(transactions.where(borrowed_at: transaction_3.borrowed_at).count).to eq(1)
    end
  end
end


