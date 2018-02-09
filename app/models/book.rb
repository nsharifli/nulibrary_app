class Book < ApplicationRecord
  has_one :inventory, dependent: :destroy
  has_many :transactions
  # Validation
  validates :isbn, presence: true, uniqueness: true
  validate :isbn_valid_length
  validates :title, presence: true
  validates_associated :inventory
  validates_presence_of :inventory

  def isbn_valid_length
    length = isbn.try(:length)
    if length != 10 && length != 13
      errors.add(:isbn, "Length should be either 10 or 13")
    end
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

  private

  def update_book_transaction(user)
    Transaction.update_book_transaction(user, id)
  end
end
