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
end