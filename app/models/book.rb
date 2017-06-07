class Book < ApplicationRecord
  has_one :inventory
  has_many :transactions
  # Validation
  validates :ibn, presence: true, uniqueness: true
  validate :ibn_valid_length
  validates :title, presence: true
  validates_presence_of :inventory

  def ibn_valid_length
    length = ibn.try(:length)
    if length != 10 && length != 13
      errors.add(:ibn, "Length should be either 10 or 13")
    end
  end

  def borrow(user_id)
    Inventory.borrow(id)
    add_borrow_entry(user_id)
  end

  def add_borrow_entry(user_id)
    Transaction.add_borrow_entry(user_id,id)
  end

  def current_quantity
    Inventory.current_quantity(id)
  end

  def total_quantity
    Inventory.total_quantity(id)
  end

  def in_stock?
    current_quantity > 0
  end
end
