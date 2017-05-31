require 'rails_helper'
require_relative '../support/pages/Book_object'

describe "Nulibrary", type: :feature, driver: :selenium do
  it "shows list of books" do
    visit books_path
    expect(page).to have_content 'All books'
  end

  it "opens book details page when clicked at book" do
    book_1 = FactoryGirl.create(:book, ibn: "1", title: "Book1")

    visit books_path
    sleep(15)

    BookPage.new.click('Book1')

    expect(page).to have_current_path(book_path(book_1.id))
  end
end