class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def borrow
    Book.find(params[:id]).borrow(current_user)
    flash.now[:success] = "Successfully borrowed"
  rescue ActiveRecord::RecordInvalid => invalid
    flash.now[:alert] = invalid.record.errors.full_messages.join(" ")
  end

  def return
    book = Book.find(params[:id])
    if book.return(current_user)
      flash[:success] = "Successfully returned #{book.title}"
      redirect_to transactions_path
    else
      flash[:notice] = "Already returned the book"
      redirect_to transactions_path
    end
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

    if quantity.to_i <= 0
      flash[:alert] = "Quantity should be greater than zero"
      redirect_to new_book_path
    elsif Book.exists?(ibn: isbn)
      flash[:alert] = "Book already exists in library"
      redirect_to new_book_path
    else
      book = BookFactory.create(isbn: isbn, quantity: quantity)
      if book
        flash[:success] = "Successfully added"
        redirect_to books_path
      else
        flash[:alert] = "Book is not found"
        redirect_to new_book_path
      end
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
