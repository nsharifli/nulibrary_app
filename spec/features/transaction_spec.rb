require 'rails_helper'

RSpec.describe "Transaction", type: :feature, driver: :selenium do
  it "shows list of checked-out books when user logged in" do
    book_1 = FactoryGirl.create(:book)
    user_1 = FactoryGirl.create(:user)

    log_in_user(user_1)
    visit book_path(book_1.id)
    click_on("Borrow")
    click_on("Transactions")

    expect(page).to have_content book_1.title
    expect(page).to have_selector ".return-button"
  end

  it "returns book from transactions page" do
    book_1 = FactoryGirl.create(:book)
    user_1 = FactoryGirl.create(:user)

    log_in_user(user_1)
    visit book_path(book_1.id)
    click_on("Borrow")
    click_on("Transactions")
    click_on("Return")

    expect(page).to have_content "Successfully returned #{book_1.title}"
    expect(page).not_to have_selector(".transactions-table", text: book_1.title)
  end
end