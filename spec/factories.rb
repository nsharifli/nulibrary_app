FactoryGirl.define do
  factory :inventory do
    total_quantity 1
    current_quantity 1
  end
  factory :book do
    ibn "MyString"
    title "MyString"

    after(:create) do |book|
      create :inventory, book: book
    end
  end
  factory :user do
    email 'example@example.com'
    password 'password'
  end
end
