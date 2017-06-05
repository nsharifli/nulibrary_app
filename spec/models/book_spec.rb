require 'rails_helper'

RSpec.describe Book, type: :model do
  it "is not valid if ibn is nil" do
    book_1 = FactoryGirl.build(:book, ibn: nil)

    book_1.valid?

    expect(book_1.errors.full_messages).to include(/can't be blank/)
  end

  it "is not valid if ibn is blank" do
    book_1 = FactoryGirl.build(:book, ibn: "  ")

    book_1.valid?

    expect(book_1.errors.full_messages).to include(/can't be blank/)
  end

  it "is valid if ibn is not blank or nil" do
    book_1 = FactoryGirl.build(:book, ibn: "1234")

    validation = book_1.valid?

    expect(validation).to eq(true)
  end

  it "is not valid if ibn is not unique" do
    book_1 = FactoryGirl.create(:book, ibn: "123")
    book_2 = FactoryGirl.build(:book, ibn: "123")

    book_2.valid?

    expect(book_2.errors.full_messages).to include(/has already been taken/)
  end

  it "is not valid if ibn length is not 10 or 13" do
    book_1 = FactoryGirl.build(:book, ibn: "123")

    book_1.valid?

    expect(book_1.errors.full_messages).to include(/Length should be either 10 or 13/)
  end


end
