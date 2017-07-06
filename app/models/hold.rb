class Hold < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def self.open_hold_request_exists?(book:, user:)
    return Hold.exists?(book: book, user: user, closed_at: nil) if user
    Hold.exists?(book: book, closed_at: nil)
  end

  def self.first_open_hold_for_book(book)
    open_holds_for_book = Hold.where(book: book, closed_at: nil)
    open_holds_for_book.order(:requested_at).first
  end
end
