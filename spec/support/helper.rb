module HelperMethods
  def log_in_user(user)
    visit user_session_path
    user_log_in_page = UserLogInPage.new
    user_log_in_page.fill_in_email(user.email)
    user_log_in_page.fill_in_password(user.password)
    user_log_in_page.click_button("Log in")
  end

  def add_book(isbn:, quantity:)
    book_new_page = BookNewPage.new
    book_new_page.fill_in_isbn(isbn)
    book_new_page.fill_in_quantity(quantity)
    book_new_page.click_button("Add")
  end
end

RSpec.configure do |config|
  config.include HelperMethods, type: :feature
end