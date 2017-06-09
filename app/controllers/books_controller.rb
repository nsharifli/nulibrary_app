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

  def return
    book = Book.find(params[:id])
    book.return(current_user)
    flash[:notice] = "Successfully returned #{book.title}"
    redirect_to transactions_path
  end

  def new

  end
end
