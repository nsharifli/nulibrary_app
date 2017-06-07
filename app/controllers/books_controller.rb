class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def borrow
    Book.find(params[:id]).borrow(current_user)
    flash[:notice] = "Successfully borrowed"
  end

end
