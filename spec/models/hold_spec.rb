require 'rails_helper'

RSpec.describe Hold, type: :model do

  describe "#open_hold_request_exists?" do
    let(:user_1) { FactoryGirl.create(:user) }
    let(:book_1) { FactoryGirl.create(:book) }

    it "returns true if request is not closed yet" do
      FactoryGirl.create(:hold, user: user_1, book: book_1)

      result = Hold.open_hold_request_exists?(book: book_1, user: user_1)

      expect(result).to eq(true)
    end

    it "returns false if request is closed" do
      FactoryGirl.create(:hold, user: user_1, book: book_1, closed_at: Time.zone.now)

      result = Hold.open_hold_request_exists?(book: book_1, user: user_1)

      expect(result).to eq(false)
    end

    it "returns false if there is not a request" do
      result = Hold.open_hold_request_exists?(book: book_1, user: user_1)

      expect(result).to eq(false)
    end
  end
end
