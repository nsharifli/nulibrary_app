require 'rails_helper'

RSpec.describe "Nulibrary", type: :feature do
  let!(:book_1) { FactoryGirl.create(:book) }
  let(:user_1) { FactoryGirl.create(:user) }

  it "shows list of books" do
    visit books_path

    expect(page).to have_content 'All books'
    expect(page).to have_content book_1.title
  end

  it "opens book details page when clicked at book" do
    visit books_path
    BookPage.new.click(book_1.title)

    expect(page).to have_current_path(book_path(book_1.id))
  end

  it "has borrow button in book details when user is logged-in and inventory is greater than zero" do
    log_in_user(user_1)
    visit book_path(book_1.id)

    expect(page).to have_selector('.borrow-button')
  end

  it "doesn't have borrow button in book details when user is not logged-in" do
    visit book_path(book_1.id)

    expect(page).not_to have_selector('.borrow-button')
  end

  it "has total quantity and current quantity information in book details" do
    visit book_path(book_1.id)

    expect(page).to have_content("Total quantity")
    expect(page).to have_content("Current quantity")
  end

  it "adds new book data via IBN and quantity if user is Admin" do
    admin = FactoryGirl.create(:user, admin: true)

    log_in_user(admin)
    visit books_path
    click_on("Add a book")
    ibn = "0321721330"
    corresponding_book = GoogleBooks.search("isbn" + ibn).first

    quantity = 2

    fill_in('ISBN', :with => ibn)
    fill_in('Quantity', :with => 2)
    click_on("Add")

    expect(page).to have_content "Successfully added"
    expect(page).to have_current_path(books_path)
    expect(page).to have_content(corresponding_book.title)
  end
end