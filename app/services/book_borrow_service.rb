module BookBorrowService
  extend self
  def borrow(user:, book:)
    ActiveRecord::Base.transaction do
      begin
        add_borrow_entry(user, book.id)
        decrease_inventory(book.id)
      rescue
        raise ActiveRecord::Rollback
      end
    end
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