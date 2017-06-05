# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FactoryGirl.create(:user, email: 'test@test.com', password: 'password')
book_1 = FactoryGirl.create(:book, title: 'New Book', ibn: '12345')
FactoryGirl.create(:inventory, total_quantity: 10, current_quantity: 4, book: book_1)
