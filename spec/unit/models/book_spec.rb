require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { FactoryGirl.build_stubbed(:book) }
  let(:user) { FactoryGirl.build_stubbed(:user) }

  describe "#in_stock" do
    it "is true when inventory for book is greater than zero" do
      allow(Inventory).to receive(:current_quantity).and_return(1)

      in_stock = book.in_stock?

      expect(in_stock).to eq(true)
    end

    it "is false when inventory for book is zero" do
      allow(Inventory).to receive(:current_quantity).and_return(0)

      in_stock = book.in_stock?

      expect(in_stock).to eq(false)
    end
  end

  describe "#current_quantity" do
    it "returns current quantity of the book" do
      expect(Inventory).to receive(:current_quantity)

      book.current_quantity
    end
  end

  describe "#total_quantity" do
    it "returns total quantity of the book" do
      expect(Inventory).to receive(:total_quantity)

      book.total_quantity
    end
  end
end