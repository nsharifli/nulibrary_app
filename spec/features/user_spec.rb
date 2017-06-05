require 'rails_helper'

RSpec.describe "User", type: :feature, driver: :selenium do
  it "checks out book through book details page" do
    book_1 = FactoryGirl.create(:book)
    book_2 = FactoryGirl.create(:book, ibn: '9876543210')
    user_1 = FactoryGirl.create(:user, email: "foo@bar.com")
    Inventory.find_by(book_id: book_2.id).update_attributes(current_quantity: 0)

    visit user_session_path
    log_in_user(user_1)

    visit book_path(book_1.id)
    click_button("Borrow")

    expect(page).to have_selector(".notice", :text => "Successfully borrowed")

    visit book_path(book_2.id)

    expect(page).to have_no_selector(".borrow-button")
  end

  it "logs in to library through home page; after user logs in, page redirects to books page" do
    user_1 = FactoryGirl.create(:user)

    visit root_path
    log_in_user(user_1)
    sleep(1)

    expect(current_path).to eq(books_path)
  end

  it "redirects to log in page when logs out" do
    user_1 = FactoryGirl.create(:user)

    visit root_path
    log_in_user(user_1)
    click_on("Sign out")

    expect(current_path).to eq(new_user_session_path)
  end
end