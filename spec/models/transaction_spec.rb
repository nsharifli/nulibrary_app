require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let (:book_1) { FactoryGirl.create(:book) }
  let (:user_1) { FactoryGirl.create(:user) }

  it "updates book entry after book is returned" do
    transaction_1 = FactoryGirl.create(:transaction, :unreturned, book: book_1, user: user_1)

    Transaction.update_book_transaction(user_1, book_1.id)
    transaction_1.reload

    expect(transaction_1.returned_at).not_to eq(nil)
  end

  it "raises an error if book is already returned" do
    FactoryGirl.create(:transaction, book: book_1, user: user_1)

    expect do
      Transaction.update_book_transaction(user_1, book_1.id)
    end.to raise_error NoMethodError
  end
end


