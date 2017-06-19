require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    describe "isbn" do
      it "is not valid if isbn is nil" do
        book_1 = FactoryGirl.build(:book, isbn: nil)

        book_1.valid?

        expect(book_1.errors.full_messages).to include(/can't be blank/)
      end

      it "is not valid if isbn is blank" do
        book_1 = FactoryGirl.build(:book, isbn: "  ")

        book_1.valid?

        expect(book_1.errors.full_messages).to include(/can't be blank/)
      end

      it "is valid if isbn is 10 or 13 digits long" do
        book_1 = FactoryGirl.build(:book, isbn: "1234567890")

        validation = book_1.valid?

        expect(validation).to eq(true)
      end

      it "is not valid if isbn is not unique" do
        book_1 = FactoryGirl.create(:book, isbn: "1234567890")
        book_2 = FactoryGirl.build(:book, isbn: "1234567890")

        book_2.valid?

        expect(book_2.errors.full_messages).to include(/has already been taken/)
      end

      it "is not valid if isbn length is not 10 or 13" do
        book_1 = FactoryGirl.build(:book, isbn: "123")

        book_1.valid?

        expect(book_1.errors.full_messages).to include(/Length should be either 10 or 13/)
      end
    end

    describe "title" do
      it "is not valid if title is nil" do
        book_1 = FactoryGirl.build(:book, title: nil)

        book_1.valid?

        expect(book_1.errors.full_messages).to include(/can't be blank/)
      end

      it "is not valid if title is blank" do
        book_1 = FactoryGirl.build(:book, title: "  ")

        book_1.valid?

        expect(book_1.errors.full_messages).to include(/can't be blank/)
      end
    end

    describe "associations" do
      it "is not valid when inventory is not present" do
        book_1 = FactoryGirl.build(:book)
        book_1.inventory = nil

        book_1.valid?

        expect(book_1.errors.full_messages).to include(/can't be blank/)
      end
    end
  end
end
