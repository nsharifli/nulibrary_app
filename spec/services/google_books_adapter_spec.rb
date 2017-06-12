require 'rails_helper'

RSpec.describe GoogleBooksAdapter, type: :unit do
  let(:isbn) {"0321721330"}
  let(:google_books) {double("Google Books")}

  it "finds title of a book given an isbn number" do
    allow(google_books).to receive_message_chain(:first, :title).and_return("Book title")

    allow(GoogleBooks).to receive(:search).with("isbn:#{isbn}").and_return(google_books)

    result = GoogleBooksAdapter.find_title(isbn)

    expect(result).to eq("Book title")
  end

  it "finds description of a book given an isbn number" do
    allow(google_books).to receive_message_chain(:first, :description).and_return("Book description")

    allow(GoogleBooks).to receive(:search).with("isbn:#{isbn}").and_return(google_books)

    result = GoogleBooksAdapter.find_description(isbn)

    expect(result).to eq("Book description")
  end

  it "finds author of a book given an isbn number" do
    allow(google_books).to receive_message_chain(:first, :authors).and_return("Book author")

    allow(GoogleBooks).to receive(:search).with("isbn:#{isbn}").and_return(google_books)

    result = GoogleBooksAdapter.find_author(isbn)

    expect(result).to eq("Book author")
  end


  it "finds image link of a book given an isbn number" do
    allow(google_books).to receive_message_chain(:first, :image_link).and_return("Image link")

    allow(GoogleBooks).to receive(:search).with("isbn:#{isbn}").and_return(google_books)

    result = GoogleBooksAdapter.find_image_link(isbn)

    expect(result).to eq("Image link")
  end

  it "returns nil when book is not found" do
    invalid_isbn = "1234567890"
    allow(google_books).to receive_message_chain(:first).and_return(nil)

    allow(GoogleBooks).to receive(:search).with("isbn:#{invalid_isbn}").and_return(google_books)

    result = GoogleBooksAdapter.find_title(invalid_isbn)

    expect(result).to eq(nil)
  end
end