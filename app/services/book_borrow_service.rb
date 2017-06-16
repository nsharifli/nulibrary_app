module BookBorrowService
  extend self
  def borrow(user:, book:)
    decrease_inventory(book.id)
    add_borrow_entry(user, book.id)
  end

  private

  def add_borrow_entry(user, book_id)
    Transaction.create!(user: user, book_id: book_id, borrowed_at: DateTime.now)
  end

  def decrease_inventory(book_id)
    inventory = Inventory.find_by(book_id: book_id)
    inventory.current_quantity -= 1
    inventory.save!
  end
end