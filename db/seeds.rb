# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FactoryGirl.create(:user, email: 'test@test.com', password: 'password')
FactoryGirl.create(:user, email: 'admin@test.com', password: 'password', admin: true)
FactoryGirl.create(:book, title: 'Crime and Punishment', author: 'Dostoyevski', image: "http://via.placeholder.com/350x150", description: "Description")
FactoryGirl.create(:book, title: 'Foundation', author: 'Isaac Asimov', image: "http://via.placeholder.com/350x150", description: "Description")
