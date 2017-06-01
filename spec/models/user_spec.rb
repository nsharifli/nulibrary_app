require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid when email address is well formed" do
    user = User.create(email: 'example@google.com', password: 'password')

    # validate user
    result = user.valid?

    # Expects to return an error message
    expect(result).to eq(true)
  end

  it "is invalid when email address is not well formed" do
    user = FactoryGirl.build(:user, email: 'dkjfdkjf')

    # validate user
    result = user.valid?

    # Expects to return an error message
    expect(result).to eq(false)
  end


end
