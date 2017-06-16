require 'rails_helper'

RSpec.describe BookReturnService, type: :unit do
  let(:book) { FactoryGirl.build_stubbed(:book) }
  let(:user) { FactoryGirl.build_stubbed(:user) }
  describe "#return" do
    it "returns book successfully if book is borrowed and not returned" do
      allow(BookReturnService).to receive(:increase_inventory).with(book).and_return(true)
      allow(BookReturnService).to receive(:update_book_transaction).with(user, book.id).and_return(true)

      result = BookReturnService.return(book: book, user: user)

      expect(result).to eq(true)
    end
  end

end