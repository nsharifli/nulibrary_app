class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def self.unreturned_transactions(book:)
    Transaction.where(book: book, returned_at: nil)
  end

  def self.unreturned_book_exists?(book:, user:)
    Transaction.exists?(book: book, user: user, returned_at: nil)
  end
end
