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
    @book = Book.new(ibn: "123456785")

  end

  def create
    isbn = book_params[:ibn]
    title = GoogleBooksAdapter.find_title(isbn)
    book = Book.new(ibn: isbn, title: title)
    inventory = Inventory.new(total_quantity: inventory_params[:quantity], current_quantity: inventory_params[:quantity])
    book.inventory = inventory
    book.save
    redirect_to books_path

  end

  private

  def book_params
    params.require(:book).permit(:ibn)
  end

  def inventory_params
    params.require(:inventory).permit(:quantity)
  end
end
