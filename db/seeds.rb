# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create(email: "john.smith@myapp.com", password: "please")
puts "User #{u1.email} created."

u2 = User.create(email: "lee.do@myappcom", password: "please")
puts "User #{u2.email} created."

m = u1.messages.create(body: "Lorem ipsum dolor sit amet.")
puts "New message created with body: #{m.body}."

m = u1.messages.create(body: "Proin sit amet metus nisi.")
puts "New message created with body: #{m.body}."

m = u2.messages.create(body: "Vestibulum non scelerisque elit.")
puts "New message created with body: #{m.body}."

m = u2.messages.create(body: "Proin sit amet metus nisi.")
puts "New message created with body: #{m.body}."

m = u2.messages.create(body: "Quisque ut arcu urna.")
puts "New message created with body: #{m.body}."
