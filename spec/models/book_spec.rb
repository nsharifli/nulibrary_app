require 'rails_helper'

RSpec.describe Book, type: :model do
  it "is not valid if ibn is nil" do
    validation = FactoryGirl.build(:book, ibn: nil, title: "Book1").valid?

    expect(validation).to eq(false)
  end
end
