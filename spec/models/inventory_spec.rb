require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it "reduces inventory when book is borrowed" do
    book_1 = FactoryGirl.create(:book, ibn: 1, title: "Book1")
    inventory_1 = FactoryGirl.create(:inventory, total_quantity: 4, current_quantity: 2, book: book_1)

    expect do
      Inventory.borrow(book_1.id)
    end.to change { inventory_1.reload.current_quantity }.by(-1)
  end
end
