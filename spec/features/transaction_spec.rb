require 'rails_helper'

RSpec.describe "Transaction", type: :feature, driver: :selenium do
  it "shows list of checked-out books when user logged in" do
    book_1 = FactoryGirl.create(:book)
    user_1 = FactoryGirl.create(:user)

    visit user_session_path
    log_in_user(user_1)
    visit book_path(book_1.id)
    click_on("Borrow")
    click_on("Transactions")

    expect(page).to have_content book_1.title
    expect(page).to have_selector ".return-button"
  end
end