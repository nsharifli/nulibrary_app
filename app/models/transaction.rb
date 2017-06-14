class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def self.add_borrow_entry(user, book_id)
    Transaction.create(user: user, book_id: book_id, borrowed_at: DateTime.now)
  end

  def self.update_book_transaction(user, book_id)
    transaction = Transaction.where(returned_at: nil).find_by(user: user, book_id: book_id)
    raise ActiveRecord::Rollback if transaction.nil?
    transaction.update_attributes(returned_at: DateTime.now)
  end
end
