module BooksHelper
  def borrow_allow?(book)
    user_signed_in? && book.in_stock?
  end

  def hold_allow?(book)
    user_signed_in? && !Transaction.unreturned_book_exists?(book: book, user: current_user)
  end
end
