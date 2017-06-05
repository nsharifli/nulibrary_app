class Book < ApplicationRecord
  # Validation
  validates :ibn, presence: true, uniqueness: true
  validate :ibn_valid_length

  def ibn_valid_length
    length = ibn.try(:length)
    if length != 10 && length != 13
      errors.add(:ibn, "Length should be either 10 or 13")
    end
  end

  def borrow
    Inventory.borrow(id)
  end

  def current_quantity
    Inventory.current_quantity(id)
  end

  def in_stock?
    current_quantity > 0
  end
end
