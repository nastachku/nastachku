# encoding: utf-8

user = User.find_or_initialize_by(email: configus.admin.email) do |u|
  u.password = configus.admin.password
  u.first_name = configus.admin.first_name
  u.last_name = configus.admin.last_name
  u.city = configus.admin.city
  u.admin = true
  u.company = "Компания"
  u.save!
  u.activate
  u.attend
  u.pay_part
end

User::PromoCode.create code: Array.new(9){ rand(36).to_s(36) }.join, user_id: user.id
