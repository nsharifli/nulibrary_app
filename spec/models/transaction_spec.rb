require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it "adds borrow entry to transactions table" do
    book_1 = FactoryGirl.create(:book)
    user_1 = FactoryGirl.create(:user)

    Transaction.add_borrow_entry(user_1, book_1.id)

    result = Transaction.find_by(user: user_1, book: book_1)

    expect(result.borrowed_at).not_to eq(nil)
  end
end
