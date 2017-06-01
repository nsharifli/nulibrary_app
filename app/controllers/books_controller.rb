class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @user = current_user
  end

end
