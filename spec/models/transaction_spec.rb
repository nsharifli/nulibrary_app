require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let (:book_1) { FactoryGirl.create(:book) }
  let (:user_1) { FactoryGirl.create(:user) }

  it "adds borrow entry to transactions table" do
    Transaction.add_borrow_entry(user_1, book_1.id)

    result = Transaction.find_by(user: user_1, book: book_1)

    expect(result.borrowed_at).not_to eq(nil)
  end

  it "updates book entry after book is returned" do
    transaction_1 = FactoryGirl.create(:transaction, :unreturned, book: book_1, user: user_1)

    Transaction.update_book_transaction(user_1, book_1.id)
    transaction_1.reload

    expect(transaction_1.returned_at).not_to eq(nil)
  end

  it "raises an exception if book is already returned" do
    FactoryGirl.create(:transaction, book: book_1, user: user_1)

    expect do
      Transaction.update_book_transaction(user_1, book_1.id)
    end.to raise_exception
  end
end


