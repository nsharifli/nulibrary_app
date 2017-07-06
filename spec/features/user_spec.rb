require 'rails_helper'

RSpec.describe "User", type: :feature, driver: :selenium do
  context "Logged in" do
    let(:user_1){ FactoryGirl.create(:user)}
    before do
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

    it "can not check out a book that he/she has currently checked out" do
      book_1 = FactoryGirl.create(:book)
      book_1.inventory.update_attributes(total_quantity: 2)
      FactoryGirl.create(:transaction, :unreturned, book: book_1, user: user_1)

      visit book_path(book_1.id)

      expect(page).to have_no_selector(".borrow-button")
      expect(page).to have_selector(".borrowed-book-button")
    end

    it "places a hold to book through book details page" do
      book_1 = FactoryGirl.create(:book)
      book_1.inventory.update_attributes!(current_quantity: 0)

      visit book_path(book_1.id)

      click_button("Hold")

      expect(page).to have_current_path(book_path(book_1.id))
      expect(page).to have_selector(".green", text: "Successfully placed a hold for #{book_1.title}")
    end

    it "can not place a hold for a book that is checked out by herself" do
      book_1 = FactoryGirl.create(:book)
      book_1.inventory.update_attributes!(current_quantity: 0)
      FactoryGirl.create(:transaction, :unreturned, book: book_1, user: user_1)

      visit book_path(book_1.id)

      expect(page).to have_selector(".borrowed-book-button")
    end

    it "can not place a hold for a book given that she placed a hold for that book before" do
      book_1 = FactoryGirl.create(:book)
      book_1.inventory.update_attributes!(current_quantity: 0)
      FactoryGirl.create(:hold, book: book_1, user: user_1)

      visit book_path(book_1.id)

      expect(page).not_to have_selector(".hold-button")
      expect(page).to have_selector(".placed-hold-button")
    end

    it "can not check-out a book that is on hold for another user" do
      #User 1 borrows a book
      book_1 = FactoryGirl.create(:book)
      visit book_path(book_1.id)
      click_on("Borrow")
      click_on("Sign out")

      #User 2 places a hold
      user_2 = FactoryGirl.create(:user)
      log_in_user(user_2)
      visit book_path(book_1.id)
      click_on("Hold")
      click_on("Sign out")

      #User 1 returns a book
      log_in_user(user_1)
      visit transactions_path
      click_on("Return")
      click_on("Sign out")

      #User 3 tries to borrow the book

      user_3 = FactoryGirl.create(:user)
      log_in_user(user_3)
      visit book_path(book_1.id)

      expect(page).not_to have_selector(".borrow-button")
      expect(page).to have_selector(".hold-button")
    end

  end

  context "Not logged in" do
    it "redirects home page to log in page if user is not logged in" do
      visit root_path

      expect(current_path).to eq(new_user_session_path)
    end
  end
end
