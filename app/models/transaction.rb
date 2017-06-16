class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def self.update_book_transaction(user, book_id)
    transaction = Transaction.where(returned_at: nil).find_by(user: user, book_id: book_id)
    transaction.update_attributes(returned_at: DateTime.now)
  end
end
