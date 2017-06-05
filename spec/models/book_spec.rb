require 'rails_helper'

RSpec.describe Book, type: :model do
  it "is not valid if ibn is nil" do
    book_1 = FactoryGirl.create(:book, ibn: nil, title: "Book1")
    validation = book_1.valid?
    expect(validation).to eq(false)
  end
end
