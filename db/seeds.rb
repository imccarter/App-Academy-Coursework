# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create!(username: "jeff", password: "<3ronda")
User.create!(username: "jeff1", password: "<3ronda")
User.create!(username: "jeff2", password: "<3ronda")

Sub.delete_all
Sub.create!(title: "ronda", moderator_id: User.first.id)
Sub.create!(title: "ronda1", moderator_id: User.first.id)
Sub.create!(title: "ronda2", moderator_id: User.first.id)


Post.delete_all
PostSub.delete_all
