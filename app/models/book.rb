class Book < ApplicationRecord
  # Validation
  validates :ibn, presence: true, uniqueness: true
  validate :ibn_valid_length

  def ibn_valid_length
    if ibn.length != 10 || ibn.length != 13
      errors.add(:ibn, "can't be in the past")
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
