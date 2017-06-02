require 'rails_helper'

RSpec.describe "Google", type: :feature do
  it "visits google.com" do
    visit 'https://www.google.com'
    expect(page).to have_content 'Google'
  end

end