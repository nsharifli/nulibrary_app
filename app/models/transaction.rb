class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def self.currently_reading_users(book:)
    Transaction.where(book: book, returned_at: nil)
  end
end
