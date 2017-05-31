require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        :ibn => "Ibn",
        :title => "Title"
      ),
      Book.create!(
        :ibn => "Ibn",
        :title => "Title"
      )
    ])
  end

  it "renders a list of books" do
    render
    assert_select "tr>td", :text => "Ibn".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
