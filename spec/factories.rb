FactoryGirl.define do
  factory :inventory do
    total_quantity 1
    current_quantity 1
    book nil
  end
  factory :book do
    ibn "MyString"
    title "MyString"
  end
  factory :user do
    email 'example@example.com'
    password 'password'
  end
end