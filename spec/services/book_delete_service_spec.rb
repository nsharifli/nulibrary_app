require 'rails_helper'

RSpec.describe BookDeleteService do
  describe "#delete" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    let(:book) { FactoryGirl.create(:book) }

    it "returns an error if book does not exist" do
      expect do
        errors = BookDeleteService.new(admin, nil).delete

        expect(errors).to include("Book does not exist in library")
      end.to change { Book.count }.by(0)
    end

    it "deletes a book successfully if book is not checked out" do
      book = FactoryGirl.create(:book)

      expect do
        errors = BookDeleteService.delete(admin, book)

        expect(errors).to be_empty
      end.to change { Book.count }.by(-1).and change { Inventory.count }.by(-1)
    end

    it "returns an error message if book is checked out" do
      book = FactoryGirl.create(:book)
      FactoryGirl.create(:transaction, book: book, user: admin)

      expect do
        errors = BookDeleteService.delete(admin, book)
        expect(errors).to include("Book cannot be deleted, since it is checked out")
      end.not_to change { Book.count }
    end

    it "returns an error message if user is not an admin" do
      book = FactoryGirl.create(:book)
      user = FactoryGirl.create(:user)

      expect do
        errors = BookDeleteService.delete(user, book)
        expect(errors).to include("You do not have a permission to delete a book")
      end.not_to change { Book.count }
    end
  end
end
