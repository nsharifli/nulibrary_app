FactoryGirl.define do
  factory :book do
    title "MyString"
    isbn ""
    quantity ""
  end
  factory :user do
    email 'example@example.com'
    password 'password'
  end
end