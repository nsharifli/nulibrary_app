require 'rails_helper'

RSpec.describe "Nulibrary", type: :feature do
  it "shows list of books" do
    book_1 = FactoryGirl.create(:book)

    visit books_path
    expect(page).to have_content 'All books'
    expect(page).to have_content book_1.title
  end

  it "opens book details page when clicked at book" do
    book_1 = FactoryGirl.create(:book, title: "Book1")

    visit books_path

    BookPage.new.click('Book1')
    expect(page).to have_current_path(book_path(book_1.id))
  end

  it "has borrow button in book details when user is logged-in and inventory is greater than zero" do
    book_1 = FactoryGirl.create(:book)
    user_1 = FactoryGirl.create(:user)

    visit user_session_path
    log_in_user(user_1)
    visit book_path(book_1.id)

    expect(page).to have_selector('.borrow-button')
  end

  it "doesn't have borrow button in book details when user is not logged-in" do
    book_1 = FactoryGirl.create(:book)

    visit book_path(book_1.id)
    expect(page).not_to have_selector('.borrow-button')
  end

  it "has total quantity and current quantity information in book details" do
    book_1 = FactoryGirl.create(:book)

    visit book_path(book_1.id)

    expect(page).to have_content("Total quantity")
    expect(page).to have_content("Current quantity")
  end
end