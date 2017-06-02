require 'capybara/dsl'

class UserLogInPage
  include Capybara::DSL

  def fill_in_email(email)
    fill_in('Email', :with => email)
  end

  def fill_in_password(password)
    fill_in('Password', :with => password)
  end

  def click_button(title)
    click_on(title)
  end
end