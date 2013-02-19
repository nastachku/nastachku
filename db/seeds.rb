# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_or_initialize_by_email configus.admin.email
user.password = configus.admin.password
user.activate
user.first_name = configus.admin.first_name 
user.last_name = configus.admin.last_name 
user.admin = true
user.save!