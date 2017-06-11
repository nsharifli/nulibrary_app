FactoryGirl.define do
  factory :transaction do
    borrowed_at "2017-06-06 17:08:34"
    returned_at "2017-06-06 17:08:34"

    trait :unreturned do
      returned_at nil
    end
  end
  factory :inventory do
    total_quantity 1
    current_quantity 1
  end
  factory :book do
    sequence(:ibn) { |n| "%010d" % n }
    title "MyString"
    author "Author"
    description "Description"
    image "Image"

    after(:build) do |book|
      book.inventory = build(:inventory, book: book)
    end
  end
  factory :user do
    email 'example@example.com'
    password 'password'
  end
end
