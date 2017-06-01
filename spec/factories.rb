FactoryGirl.define do
  factory :book do
    ibn "MyString"
    title "MyString"
  end
  factory :user do
    email 'example@example.com'
    password 'password'
  end
end