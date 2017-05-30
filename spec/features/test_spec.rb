require 'rails_helper'

describe "Google", type: :feature do
  it "visits google.com", :driver => :selenium do
    visit 'https://www.google.com'
    expect(page).to have_content 'Google'
  end

end