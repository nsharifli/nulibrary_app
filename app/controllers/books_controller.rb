class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    inventory = Inventory.find_by(book_id: @book.id)
    @current_quantity = inventory.present? ? inventory.current_quantity : 0
    # 1. current_quantity is used at view 2. assign to boolean 3. create helper . Which way is better?
  end

  def borrow
    Inventory.borrow(params[:id])
    flash[:notice] = "Successfully borrowed"
  end

end
