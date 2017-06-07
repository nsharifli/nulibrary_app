class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def self.add_borrow_entry(user, book_id)
    Transaction.create(user: user, book_id: book_id, borrowed_at: DateTime.now)
  end
end
