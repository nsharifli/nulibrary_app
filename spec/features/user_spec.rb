require 'rails_helper'
require_relative '../support/pages/Book_object'

describe "User", type: :feature, driver: :selenium do
  it "checks out book through book details page" do
    book_1 = FactoryGirl.create(:book, ibn: "1", title: "Book1")
    book_2 = FactoryGirl.create(:book, ibn: "2", title: "Book2")
    user_1 = FactoryGirl.create(:user, email: "foo@bar.com")

    visit user_session_path
    fill_in('Email', :with => user_1.email)
    fill_in('Password', :with => user_1.password)
    click_button("Log in")

    visit book_path(book_1.id)
    click_button("Borrow")

    expect(page).to have_selector(".notice", :text => "Successfully borrowed")

    visit book_path(book_2.id)

    expect(page).to have_no_selector(".borrow-button")
  end
end