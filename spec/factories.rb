FactoryGirl.define do
  factory :inventory do
    total_quantity 1
    current_quantity 1
  end
  factory :book do
    sequence(:ibn) { |n| "%010d" % n }
    title "MyString"

    after(:build) do |book|
      book.inventory = build(:inventory, book: book)
    end
  end
  factory :user do
    email 'example@example.com'
    password 'password'
  end
end
