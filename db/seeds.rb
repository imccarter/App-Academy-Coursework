# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CatRentalRequest.create(start_date: '2012.06.04', end_date: '2013.01.01', cat_id: 2)

CatRentalRequest.create(start_date: '2012.08.01', end_date: '2013.03.01', cat_id: 2, status: "APPROVED")

CatRentalRequest.create(start_date: '2012.12.04', end_date: '2013.09.01', cat_id: 2, status: "APPROVED")

CatRentalRequest.create(start_date: '2010.06.04', end_date: '2011.01.01', cat_id: 3, status: "DENIED")

Cat.create!(name: "Mr. Bigglesworth", color: "WHITE", birth_date: '2007.01.01', sex: "M", description: "This cat is big")

Cat.create!(name: "Nimbus", color: "BLACK", birth_date: '2006.01.01', sex: "M", description: "Anklebiter.")

Cat.create!(name: "Kathy", color: "PURPLE", birth_date: '2005.05.01', sex: "F", description: "Sleepy cat.")
