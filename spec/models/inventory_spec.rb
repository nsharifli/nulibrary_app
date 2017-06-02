require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it "is reduced by one when a book is borrowed" do
    book_1 = FactoryGirl.create(:book, ibn: 1, title: "Book1")
    inventory_1 = FactoryGirl.create(:inventory, total_quantity: 4, current_quantity: 2, book: book_1)

    expect do
      Inventory.borrow(book_1.id)
    end.to change { inventory_1.reload.current_quantity }.by(-1)
  end

  describe "#current quantity" do
    it "returns current quantity when the book is in inventory" do
      book_1 = FactoryGirl.create(:book, ibn: 1, title: "Book1")
      FactoryGirl.create(:inventory, total_quantity: 4, current_quantity: 2, book: book_1)

      expect(Inventory.current_quantity(book_1.id)).to eq(2)
    end

    it "returns zero when the book is not in inventory" do
      book_1 = FactoryGirl.create(:book, ibn: 1, title: "Book1")

      expect(Inventory.current_quantity(book_1.id)).to eq(0)
    end
  end
end
