require 'rails_helper'

RSpec.describe BookHoldService do
  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }

  describe "#hold" do
    it "successfully places a hold for a book" do
      Timecop.freeze(Time.zone.now)

      BookHoldService.hold(user: user, book: book)

      expect(hold.requested_at).to eq(Time.zone.now)
      expect(hold.closed_at).to be_nil
      expect(hold.sent_email).to be_nil
    end
  end

  def hold
    @hold ||= Hold.find_by(user: user, book: book)
  end
end