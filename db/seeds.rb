# encoding: utf-8

user = User.find_or_initialize_by_email configus.admin.email
user.password = configus.admin.password
user.first_name = configus.admin.first_name 
user.last_name = configus.admin.last_name 
user.city = configus.admin.city
user.admin = true
user.save!
user.activate
user.attend
user.pay_part
User::PromoCode.create({ code: Array.new(9){ rand(36).to_s(36) }.join, user_id: user.id })
