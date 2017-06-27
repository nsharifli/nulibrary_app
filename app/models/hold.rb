class Hold < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def self.open_hold_request_exists?(book:, user:)
    Hold.exists?(book: book, user: user, closed_at: nil)
  end
end
