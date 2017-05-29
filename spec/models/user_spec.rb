require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "takes valid email addresses" do
    user = User.create(email: 'example@google.com', password: 'password')

    # validate user
    result = user.valid?

    # Expects to return an error message
    expect(result).to eq(true)
  end
end
