module BookBorrowService
  extend self
  def borrow(user:, book:)
    Inventory.borrow(book.id) && Transaction.add_borrow_entry(user, book.id)
  end
end