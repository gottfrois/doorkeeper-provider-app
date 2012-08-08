# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Rake::Task["db:drop"].invoke

# Users
u1 = User.create(email: "john.smith@myapp.com", password: "please")
puts "User #{u1.email} created."

u2 = User.create(email: "lee.do@myappcom", password: "please")
puts "User #{u2.email} created."

# Conversations & Messages
c = u1.conversations.new
m = c.messages.build(body: "Lorem ipsum dolor sit amet.")
m.save!
c.save!
puts "New message created with body: #{m.body}."

c = u1.conversations.new
m = c.messages.build(body: "Proin sit amet metus nisi.")
m.save!
c.save!
puts "New message created with body: #{m.body}."

c = u2.conversations.new
m = c.messages.build(body: "Vestibulum non scelerisque elit.")
m.save!
c.save!
puts "New message created with body: #{m.body}."

c = u2.conversations.new
m = c.messages.build(body: "Proin sit amet metus nisi.")
m.save!
c.save!
puts "New message created with body: #{m.body}."

c = u2.conversations.new
m = c.messages.build(body: "Quisque ut arcu urna.")
m.save!
c.save!
puts "New message created with body: #{m.body}."
