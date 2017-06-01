class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
  end

  def borrow
    flash[:notice] = "Successfully borrowed"
  end

end
