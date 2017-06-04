require 'rails_helper'

RSpec.describe "User", type: :feature, driver: :selenium do
  it "checks out book through book details page" do
    book_1 = FactoryGirl.create(:book, ibn: "1", title: "Book1")
    book_2 = FactoryGirl.create(:book, ibn: "2", title: "Book2")
    user_1 = FactoryGirl.create(:user, email: "foo@bar.com")
    Inventory.find_by(book_id: book_2.id).update_attributes(current_quantity: 0)

    visit user_session_path

    user_log_in_page = UserLogInPage.new
    user_log_in_page.fill_in_email(user_1.email)
    user_log_in_page.fill_in_password(user_1.password)
    user_log_in_page.click_button("Log in")

    visit book_path(book_1.id)
    click_button("Borrow")

    expect(page).to have_selector(".notice", :text => "Successfully borrowed")
    visit book_path(book_2.id)

    expect(page).to have_no_selector(".borrow-button")
  end
end