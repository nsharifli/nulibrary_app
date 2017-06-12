require 'capybara/dsl'

class BookNewPage
  include Capybara::DSL

  def fill_in_isbn(isbn)
    fill_in('Ibn', with: isbn)
  end

  def fill_in_quantity(quantity)
    fill_in('Quantity', with: quantity)
  end

  def click_button(title)
    click_on(title)
  end
end