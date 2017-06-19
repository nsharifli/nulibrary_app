require 'rails_helper'

RSpec.describe "Transaction", type: :feature, driver: :selenium do
  let(:book_1) { FactoryGirl.create(:book) }
  let(:user_1) { FactoryGirl.create(:user) }

  before do
    log_in_user(user_1)
  end

  it "shows list of checked-out books when user logged in" do
    visit book_path(book_1.id)
    click_on("Borrow")
    click_on("Transactions")

    expect(page).to have_content book_1.title
    expect(page).to have_selector ".return-button"
  end

  it "returns book from transactions page" do
    visit book_path(book_1.id)
    click_on("Borrow")
    click_on("Transactions")
    click_on("Return")

    expect(page).to have_content "Successfully returned #{book_1.title}"
    expect(page).not_to have_selector("#transactions-table", text: book_1.title)
  end

  it "borrows the same book second time and returns it" do
    visit book_path(book_1.id)
    click_on("Borrow")
    click_on("Transactions")
    click_on("Return")

    visit book_path(book_1.id)
    click_on("Borrow")
    click_on("Transactions")
    click_on("Return")


    expect(page).to have_content "Successfully returned #{book_1.title}"
    expect(page).not_to have_selector("#transactions-table", text: book_1.title)
  end

  it "has 6 pages in pagination when we have 30 borrowed books that haven't been returned" do
    30.times { FactoryGirl.create(:transaction, :unreturned, book: book_1, user: user_1) }
    number_of_pages = 6
    number_of_pagination_tabs = number_of_pages + 2

    visit transactions_path

    expect(page).to have_selector('tfoot .item', count: number_of_pagination_tabs)
  end

  it "has 5 transactions in each page" do
    30.times { FactoryGirl.create(:transaction, :unreturned, book: book_1, user: user_1) }
    transactions_per_page = 5

    visit transactions_path
    click_on("3")

    expect(page).to have_selector('tbody tr', count: transactions_per_page)
  end
end