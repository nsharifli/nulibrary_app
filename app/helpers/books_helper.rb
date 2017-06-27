module BooksHelper
  def borrow_allow?(book)
    user_signed_in? && book.in_stock?
  end

  def hold_allow?(book)
    user_signed_in? && !checked_out_book?(book) &&
      !placed_hold?(book)
  end

  def checked_out_book?(book)
    user_signed_in? && Transaction.unreturned_book_exists?(book: book, user: current_user)
  end

  def placed_hold?(book)
    user_signed_in? && Hold.open_hold_request_exists?(book: book, user: current_user)
  end
end
