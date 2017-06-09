require 'rails_helper'

RSpec.describe GoogleBooksAdapter, type: :unit do
  it "finds title of a book given an isbn number" do
    isbn = "0321721330"

    allow(GoogleBooks).to receive(:search).with("isbn:#{isbn}").and_return("Book title")

    result = GoogleBooksAdapter.find_title(isbn)

    expect(result).to eq("Book title")
  end
end