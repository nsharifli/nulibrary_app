class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def self.currently_reading_user(book:)
    transaction = Transaction.find_by(book: book, returned_at: nil)
    transaction.user_id
  end
end
