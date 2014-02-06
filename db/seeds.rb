# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: 'Computer', email: 'computer', password: 'password', password_confirmation: 'password')

User.create(name: 'Imran', email: 'imran@imran.com', password: 'password', password_confirmation: 'password')

User.create(name: 'Tim', email: 'Tim@tim.com', password: 'password', password_confirmation: 'password')

User.create(name: 'Tom', email: 'Tom@tom.com', password: 'password', password_confirmation: 'password')

User.create(name: 'Clem', email: 'clem@clem.com', password: 'password', password_confirmation: 'password')
