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
    if current_user.admin?
      @book = Book.new
    else
      redirect_to root_path
    end

  end

  def create
    isbn = book_params[:ibn]
    quantity = inventory_params[:quantity]
    book = BookFactory.create(isbn: isbn, quantity: quantity)

    if quantity.to_i <= 0
      flash[:notice] = "Quantity should be greater than zero"
      redirect_to new_book_path
    elsif !book
      flash[:notice] = "Book is not found"
      redirect_to new_book_path
    else
      flash[:notice] = "Successfully added"
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:ibn)
  end

  def inventory_params
    params.require(:inventory).permit(:quantity)
  end
end
