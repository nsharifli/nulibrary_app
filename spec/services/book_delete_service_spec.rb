require 'rails_helper'

RSpec.describe BookDeleteService do
  describe "#delete" do
    it "deletes a book from library successfully if book is not checked out" do
      book = FactoryGirl.create(:book)

      expect do
        BookDeleteService.delete(book)
      end.to change { Book.count }.by(-1).and change { Inventory.count }.by(-1)
    end

    it "doesn't delete the book if book is checked out" do
      book = FactoryGirl.create(:book)
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:transaction, book: book, user: user)

      expect do
        BookDeleteService.delete(book)
      end.not_to change { Book.count }
    end
  end
end
