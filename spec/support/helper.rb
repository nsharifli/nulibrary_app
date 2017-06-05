module HelperMethods
  def log_in_user(user)
    user_log_in_page = UserLogInPage.new
    user_log_in_page.fill_in_email(user.email)
    user_log_in_page.fill_in_password(user.password)
    user_log_in_page.click_button("Log in")
  end
end

RSpec.configure do |config|
  config.include HelperMethods, type: :feature
end