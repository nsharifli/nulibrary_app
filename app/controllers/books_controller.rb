class BooksController < ApplicationController
  def index
    @books = Book.order(:title).paginate(page: params[:page], per_page: 5)
  end

  def show
    @book = Book.find(params[:id])
    @currently_using_users = Transaction.unreturned_transactions(book: @book)
  end

  def borrow
    if user_signed_in?
      book = Book.find(params[:id])
      book_borrowed = BookBorrowService.borrow(user: current_user, book: book)

      if book_borrowed
        flash.now[:success] = "Successfully borrowed"
      else
        flash.now[:alert] = "Book is not available anymore"
      end
    else
      flash.now[:alert] = "Please log in to borrow a book"
    end
  end

  def return
    book = Book.find(params[:id])
    book_returned = BookReturnService.return(user: current_user, book: book)

    if book_returned
      flash[:success] = "Successfully returned #{book.title}"
      redirect_to transactions_path
    else
      flash[:notice] = "Already returned the book"
      redirect_to transactions_path
    end
  end

  def hold
    book = Book.find(params[:id])
    flash[:success] = "Successfully placed a hold for #{book.title}"
    redirect_to book_path(book.id)
  end

  def new
    if current_user.admin?
      @book = Book.new
    else
      redirect_to root_path
    end

  end

  def create
    isbn = book_params[:isbn]
    quantity = inventory_params[:quantity]

    if quantity.to_i <= 0
      flash[:alert] = "Quantity should be greater than zero"
      redirect_to new_book_path
    elsif Book.exists?(isbn: isbn)
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
    params.require(:book).permit(:isbn)
  end

  def inventory_params
    params.require(:inventory).permit(:quantity)
  end
end
