require 'rails_helper'

describe "Nulibrary", type: :feature do
  it "shows list of books", :driver => :selenium do
    visit '/books'
    expect(page).to have_content 'All books'
  end
end