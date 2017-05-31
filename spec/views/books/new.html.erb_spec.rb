require 'rails_helper'

RSpec.describe "books/new", type: :view do
  before(:each) do
    assign(:book, Book.new(
      :ibn => "MyString",
      :title => "MyString"
    ))
  end

  it "renders new book form" do
    render

    assert_select "form[action=?][method=?]", books_path, "post" do

      assert_select "input#book_ibn[name=?]", "book[ibn]"

      assert_select "input#book_title[name=?]", "book[title]"
    end
  end
end
