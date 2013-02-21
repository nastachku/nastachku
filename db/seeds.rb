# encoding: utf-8

user = User.find_or_initialize_by_email configus.admin.email
user.password = configus.admin.password
user.first_name = configus.admin.first_name
user.last_name = configus.admin.last_name
user.city = "Ульяновск"
user.admin = true
user.save!
user.activate
