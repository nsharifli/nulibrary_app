class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def self.add_borrow_entry(user, book)
    Transaction.create(user: user, book: book, borrowed_at: DateTime.now)
  end
end
