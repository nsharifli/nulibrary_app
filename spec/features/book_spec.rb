require 'rails_helper'

RSpec.describe "Nulibrary", type: :feature, driver: :selenium do
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

  it "adds new book data via ISBN and quantity if user is Admin" do
    admin = FactoryGirl.create(:user, admin: true)

    log_in_user(admin)
    visit new_book_path
    isbn = "0321721330"
    quantity = 2
    allow(GoogleBooksAdapter).to receive(:find_title).with(isbn).and_return("Foundation")
    book_title  = GoogleBooksAdapter.find_title(isbn)

    add_book(isbn: isbn, quantity: quantity )

    expect(page).to have_content "Successfully added"
    expect(page).to have_current_path(books_path)
    expect(page).to have_content(book_title)
  end

  it "doesn't add a new book if quantity is zero" do
    admin = FactoryGirl.create(:user, admin: true)

    log_in_user(admin)
    visit new_book_path
    isbn = "0321721330"
    quantity = 0
    allow(GoogleBooksAdapter).to receive(:find_title).with(isbn).and_return("Book title")

    add_book(isbn: isbn, quantity: quantity)

    expect(page).to have_content "Quantity should be greater than zero"
    expect(page).to have_current_path(new_book_path)
  end

  it "doesn't add a new book if quantity is less than zero" do
    admin = FactoryGirl.create(:user, admin: true)

    log_in_user(admin)
    visit new_book_path
    isbn = "0321721330"
    quantity = -2
    allow(GoogleBooksAdapter).to receive(:find_title).with(isbn).and_return("Book title")

    add_book(isbn: isbn, quantity: quantity)

    expect(page).to have_content "Quantity should be greater than zero"
    expect(page).to have_current_path(new_book_path)
  end

  it "doesn't add a new book if book is already in database" do
    admin = FactoryGirl.create(:user, admin: true)

    log_in_user(admin)
    visit new_book_path
    isbn = "0321721330"
    quantity = 2
    allow(GoogleBooksAdapter).to receive(:find_title).with(isbn).and_return("Book title")

    add_book(isbn: isbn, quantity: quantity)
    visit new_book_path
    add_book(isbn: isbn, quantity: quantity)

    expect(page).to have_content "Book already exists in library"
    expect(page).to have_current_path(new_book_path)
  end

  it "has 7 pages in pagination when we have 31 books" do
    30.times { FactoryGirl.create(:book) }
    number_of_pages = 7
    number_of_pagination_tabs = number_of_pages + 2

    visit books_path

    expect(page).to have_selector('tfoot .item', count: number_of_pagination_tabs)
  end

  it "has 5 books in each page in book index" do
    30.times { FactoryGirl.create(:book) }
    number_of_books_per_page = 5

    visit books_path
    click_on ("2")

    expect(page).to have_selector('tbody tr', count: number_of_books_per_page)
  end
end