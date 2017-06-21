require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "#currently_reading_users" do
    it "returns the user who currently has that book" do
      book_1 = FactoryGirl.create(:book)
      user_1 = FactoryGirl.create(:user)
      FactoryGirl.create(:transaction, :unreturned, book: book_1, user: user_1)

      result = Transaction.currently_reading_user(book: book_1)

      expect(result).to eq(user_1.id)
    end
  end

end


