class Inventory < ApplicationRecord
  belongs_to :book

  def self.borrow(id)
    inventory = Inventory.find_by(book_id: id)
    inventory.current_quantity -= 1
    inventory.save
  end
end
