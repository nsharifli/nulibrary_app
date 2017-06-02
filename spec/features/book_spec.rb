require 'rails_helper'

RSpec.describe "Nulibrary", type: :feature do
  it "shows list of books" do
    visit books_path
    expect(page).to have_content 'All books'
  end

  it "opens book details page when clicked at book" do
    book_1 = FactoryGirl.create(:book, ibn: "1", title: "Book1")

    visit books_path

    BookPage.new.click('Book1')
    expect(page).to have_current_path(book_path(book_1.id))
  end

  it "has borrow button in book details when user is logged-in and inventory is greater than zero" do
    book_1 = FactoryGirl.create(:book, ibn: "1", title: "Book1")
    user_1 = FactoryGirl.create(:user, email: "foo@bar.com")
    FactoryGirl.create(:inventory, total_quantity: 4, current_quantity: 2, book: book_1)

    visit user_session_path
    fill_in('Email', :with => user_1.email)
    fill_in('Password', :with => user_1.password)
    click_button("Log in")

    visit book_path(book_1.id)

    expect(page).to have_selector('.borrow-button')
  end

  it "doesn't have borrow button in book details when user is not logged-in" do
    book_1 = FactoryGirl.create(:book, ibn: "1", title: "Book1")

    visit book_path(book_1.id)
    expect(page).not_to have_selector('.borrow-button')
  end
end