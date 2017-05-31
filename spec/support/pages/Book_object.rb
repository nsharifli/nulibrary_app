require 'capybara/dsl'

class BookPage
  include Capybara::DSL

  def click(title)
    find('a', text: title).click
  end
end