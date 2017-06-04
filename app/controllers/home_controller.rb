class HomeController < ApplicationController
  def index
    redirect_to new_user_session_path if !user_signed_in?
    redirect_to books_path if user_signed_in?
  end
end
