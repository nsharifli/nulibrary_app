require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it "is reduced by one when a book is borrowed" do
    book_1 = FactoryGirl.create(:book)
    inventory_1 = Inventory.find_by(book_id: book_1.id)

    expect do
      Inventory.borrow(book_1.id)
    end.to change { inventory_1.reload.current_quantity }.by(-1)
  end

  describe "#current quantity" do
    it "returns current quantity when the book is in inventory" do
      book_1 = FactoryGirl.create(:book)

      expect(Inventory.current_quantity(book_1.id)).to eq(1)
    end

    it "returns zero when the book is not in inventory" do
      book_1 = FactoryGirl.create(:book)
      Inventory.find_by(book_id: book_1.id).update_attributes(current_quantity: 0)

      expect(Inventory.current_quantity(book_1.id)).to eq(0)
    end
  end

  describe "validation" do
    it "is not valid if total_quantity is nil" do
      book_1 = FactoryGirl.create(:book)
      inventory_1 = FactoryGirl.build(:inventory, total_quantity: nil, book: book_1)

      inventory_1.valid?

      expect(inventory_1.errors.full_messages).to include(/can't be blank/)
    end

    it "is not valid if total_quantity is less than zero" do
      book_1 = FactoryGirl.create(:book)
      inventory_1 = FactoryGirl.build(:inventory, total_quantity: -2, book: book_1)

      inventory_1.valid?

      expect(inventory_1.errors.full_messages).to include(/must be greater than or equal to 0/)
    end

    it "is not valid if current_quantity is nil" do
      book_1 = FactoryGirl.create(:book)
      inventory_1 = FactoryGirl.build(:inventory, current_quantity: nil, book: book_1)

      inventory_1.valid?

      expect(inventory_1.errors.full_messages).to include(/can't be blank/)
    end

    it "is not valid if current_quantity is less than zero" do
      book_1 = FactoryGirl.create(:book)
      inventory_1 = FactoryGirl.build(:inventory, current_quantity: -2, book: book_1)

      inventory_1.valid?

      expect(inventory_1.errors.full_messages).to include(/must be greater than or equal to 0/)
    end
  end
end
