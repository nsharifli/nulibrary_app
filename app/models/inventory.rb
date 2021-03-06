class Inventory < ApplicationRecord
  belongs_to :book
  validates :total_quantity, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :current_quantity, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: :total_quantity}

  def self.current_quantity(book_id)
    inventory = Inventory.find_by(book_id: book_id)
    inventory.current_quantity
  end

  def self.total_quantity(book_id)
    inventory = Inventory.find_by(book_id: book_id)
    inventory.total_quantity
  end
end
