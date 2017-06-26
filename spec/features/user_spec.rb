require 'rails_helper'

RSpec.describe "User", type: :feature do
  context "Logged in" do
    before do
      user_1 = FactoryGirl.create(:user)
      visit root_path
      log_in_user(user_1)
    end

    it "logs in to library through home page; after user logs in, page redirects to books page" do
      expect(current_path).to eq(books_path)
    end

    it "redirects to log in page when logs out" do
      click_on("Sign out")

      expect(current_path).to eq(new_user_session_path)
    end

    it "redirects home page to books page if user is logged in" do
      visit root_path

      expect(current_path).to eq(books_path)
    end

    it "checks out book through book details page" do
      book_1 = FactoryGirl.create(:book)
      book_2 = FactoryGirl.create(:book, isbn: '9876543210')
      book_2.inventory.update_attributes!(current_quantity: 0)

      visit book_path(book_1.id)
      click_button("Borrow")

      expect(page).to have_selector(".green", :text => "Successfully borrowed")

      visit book_path(book_2.id)

      expect(page).to have_no_selector(".borrow-button")
    end

    it "places a hold to book through book details page" do
      book_1 = FactoryGirl.create(:book)
      book_1.inventory.update_attributes!(current_quantity: 0)

      visit book_path(book_1.id)

      click_button("Hold")

      expect(page).to have_current_path(book_path(book_1.id))
      expect(page).to have_selector(".green", text: "Successfully placed a hold for #{book_1.title}")
    end
  end

  context "Not logged in" do
    it "redirects home page to log in page if user is not logged in" do
      visit root_path

      expect(current_path).to eq(new_user_session_path)
    end
  end
end
