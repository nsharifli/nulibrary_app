require 'rails_helper'

RSpec.describe Book, type: :model do
  it "is not valid if ibn is nil" do
    validation = FactoryGirl.build(:book, ibn: nil, title: "Book1").valid?

    expect(validation).to eq(false)
  end

  it "is not valid if ibn is blank" do
    validation = FactoryGirl.build(:book, ibn: "  ", title: "Book1").valid?

    expect(validation).to eq(false)
  end

  it "is valid if ibn is not blank or nil" do
    validation = FactoryGirl.build(:book, ibn: "1234", title: "Book1").valid?

    expect(validation).to eq(true)
  end


end
