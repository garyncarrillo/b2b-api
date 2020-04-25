# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.find_or_create_by(email: 'admin@subasta.com', first_name: 'John', last_name: 'Doe', phone: '(333) 333-3333') do |user|
  user.password = 'Pass1111$'
end

CustomerUser.find_or_create_by(email: 'customer@subasta.com', first_name: 'John', last_name: 'Wick', phone: '(333) 333-3333') do |user|
  user.password = 'Pass1111$'
end
