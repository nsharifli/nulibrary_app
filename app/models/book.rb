class Book < ApplicationRecord
  def borrow
    Inventory.borrow(id)
  end

  def current_quantity
    Inventory.current_quantity(id)
  end

end
