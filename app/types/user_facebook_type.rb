class UserFacebookType < User
  include BasicType

  permit :email, :first_name, :last_name, :photo, :facebook

  validates :email, presence: true
end
