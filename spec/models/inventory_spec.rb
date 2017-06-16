require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let (:book_1) { FactoryGirl.create(:book) }

  describe "#current quantity" do
    it "returns current quantity" do
      expect(Inventory.current_quantity(book_1.id)).to eq(1)
    end
  end

  describe "#total_quantity" do
    it "returns total quantity of a book in inventory" do
      expect(Inventory.total_quantity(book_1.id)).to eq(1)
    end
  end

  describe "validation" do
    it "is not valid if total_quantity is nil" do
      inventory_1 = FactoryGirl.build(:inventory, total_quantity: nil, current_quantity: nil, book: book_1)

      inventory_1.valid?

      expect(inventory_1.errors.full_messages).to include(/can't be blank/)
    end

    it "is not valid if total_quantity is less than zero" do
      inventory_1 = FactoryGirl.build(:inventory, total_quantity: -2, book: book_1)

      inventory_1.valid?

      expect(inventory_1.errors.full_messages).to include(/must be greater than or equal to 0/)
    end

    it "is not valid if current_quantity is nil" do
      inventory_1 = FactoryGirl.build(:inventory, current_quantity: nil, book: book_1)

      inventory_1.valid?

      expect(inventory_1.errors.full_messages).to include(/can't be blank/)
    end

    it "is not valid if current_quantity is less than zero" do
      inventory_1 = FactoryGirl.build(:inventory, current_quantity: -2, book: book_1)

      inventory_1.valid?

      expect(inventory_1.errors.full_messages).to include(/must be greater than or equal to 0/)
    end

    it "is not valid if current_quantity is greater than total_quantity" do
      inventory_1 = FactoryGirl.build(:inventory, total_quantity: 1, current_quantity: 2, book: book_1)

      inventory_1.valid?

      expect(inventory_1.errors.full_messages).to include(/must be less than or equal to #{inventory_1.total_quantity}/)
    end
  end
end
