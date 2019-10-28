# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: "sai@radius.com", password: "radius", name: "Sai", bio: "I like cheese.", lat: 34.067142, lng: -118.451345)
User.create!(email: "kevin@radius.com", password: "radius", name: "Kevin", bio: "I like dogs.", lat: 35.067142, lng: -110.451345)
User.create!(email: "lucas@radius.com", password: "radius", name: "Lucas", bio: "I like money.", lat: 38.067142, lng: -120.451345)
User.create!(email: "elena@radius.com", password: "radius", name: "Elena", bio: "I like basketball.", lat: 40.067142, lng: -102.451345)
User.create!(email: "sriram@radius.com", password: "radius", name: "Sriram", bio: "I like money.", lat: 45.067142, lng: -18.451345)
