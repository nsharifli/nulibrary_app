module BooksHelper
  def borrow_allow?(book)
    user_signed_in? && book.in_stock?
  end
end
