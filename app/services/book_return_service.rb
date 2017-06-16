module BookReturnService
  extend self

  def return(book:, user:)
    increase_inventory(book)
    update_book_transaction(user, book.id)
  end

  private

  def increase_inventory(book)
    inventory = Inventory.find_by(book_id: book_id)
    inventory.current_quantity += 1
    inventory.save!
  end

  def update_book_transaction(user, book_id)
    transaction = Transaction.where(returned_at: nil).find_by!(user: user, book_id: book_id)
    transaction.update_attributes!(returned_at: DateTime.now)
  end
end