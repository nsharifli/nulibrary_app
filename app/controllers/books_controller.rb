class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @current_quantity = Inventory.find_by(book_id: @book.id).current_quantity
  end

  def borrow
    flash[:notice] = "Successfully borrowed"
  end
end
