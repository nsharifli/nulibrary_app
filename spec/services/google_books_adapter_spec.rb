require 'rails_helper'

RSpec.describe GoogleBooksAdapter, type: :unit do
  it "finds title of a book given an isbn number" do
    isbn = "0321721330"
    google_books = double("Google Books")
    allow(google_books).to receive_message_chain(:first, :title).and_return("Book title")

    allow(GoogleBooks).to receive(:search).with("isbn:#{isbn}").and_return(google_books)

    result = GoogleBooksAdapter.find_title(isbn)

    expect(result).to eq("Book title")
  end
end