# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

# # Fun testing
# sai = User.create!(email: "sai@radius.com", password: "radius", name: "Sai", bio: "I like soccer.", lat: 34.067142, lng: -118.451345)
# kev = User.create!(email: "kevin@radius.com", password: "radius", name: "Kevin", bio: "I like dogs.", lat: 35.067142, lng: -110.451345)
# luc = User.create!(email: "lucas@radius.com", password: "radius", name: "Lucas", bio: "I like money.", lat: 38.067142, lng: -120.451345)
# ele = User.create!(email: "elena@radius.com", password: "radius", name: "Elena", bio: "I like basketball.", lat: 40.067142, lng: -102.451345)
# sri = User.create!(email: "sriram@radius.com", password: "radius", name: "Sriram", bio: "I like cats.", lat: 45.067142, lng: -18.451345)

# sai.posts.create!(content: "I like Ronaldo.")
# sai.posts.create!(content: "I like Real Madrid.")
# sai.posts.create!(content: "FIFA is fun.")
# kev.posts.create!(content: "I like small dogs.")
# kev.posts.create!(content: "uwu")
# luc.posts.create!(content: "Money grows on trees.")
# ele.posts.create!(content: "Dunkin' Donut")
# sri.posts.create!(content: "Hello")
# sri.posts.create!(content: "I exist")

# sai.follow(kev)
# sai.follow(luc)
# sai.follow(ele)
# sai.follow(sri)
# kev.follow(sai)
# luc.follow(sai)
# luc.follow(kev)
# ele.follow(sai)
# ele.follow(sri)
# sri.follow(sai)
# sri.follow(kev)

# Load testing
# Create users
values = ""
1000.times { |n| 
  name  = "seed-#{n+1}"
  email = "#{name}@radius.com"
  bio = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  password = "radius"
  lat = "34.067142"
  lng = "-118.451346"
  values.concat("('#{name}','#{email}','#{bio}','#{password}',#{lat},#{lng},'#{Time.now}','#{Time.now}'),")
}
values = values[0...-1]
ActiveRecord::Base.connection.execute("INSERT INTO users (name, email, bio, encrypted_password, lat, lng, created_at, updated_at) VALUES #{values}")

# Create posts
values = (User.first(10).map { |u| "('#{u.bio}',#{u.id},'#{Time.now}','#{Time.now}')" } * 500).join(",")
ActiveRecord::Base.connection.execute("INSERT INTO posts (content, user_id, created_at, updated_at) VALUES #{values}")

# Following people
user = User.first

values = User.first(10).map { |u| "(#{user.id},#{u.id},'#{Time.now}','#{Time.now}')"  }.join(",")
ActiveRecord::Base.connection.execute("INSERT INTO relationships (follower_id, followed_id, created_at, updated_at) VALUES #{values}")
ActiveRecord::Base.connection.execute("INSERT INTO conversations (sender_id, recipient_id, created_at, updated_at) VALUES #{values}")

body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
values = Conversation.all.map { |u| "('#{body}',#{u.id},#{user.id},'#{Time.now}','#{Time.now}')"  }.join(",")
500.times do |n|
  ActiveRecord::Base.connection.execute("INSERT INTO messages (body, conversation_id, user_id, created_at, updated_at) VALUES #{values}")
end

values = User.last(900).map { |u| "(#{u.id},#{user.id},'#{Time.now}','#{Time.now}')"  }.join(",")
ActiveRecord::Base.connection.execute("INSERT INTO relationships (follower_id, followed_id, created_at, updated_at) VALUES #{values}")
