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
      @book = Book.new(ibn: "123456785")
    else
      redirect_to root_path
    end

  end

  def create
    isbn = book_params[:ibn]
    title = GoogleBooksAdapter.find_title(isbn)
    if title.nil?
      flash[:notice] = "Book is not found"
      redirect_to new_book_path
    else
      book = Book.new(ibn: isbn, title: title)
      inventory = Inventory.new(total_quantity: inventory_params[:quantity], current_quantity: inventory_params[:quantity])
      book.inventory = inventory
      book.save
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
