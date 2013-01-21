
class UserEditType < User
  include BasicType

  attr_accessible :password, :password_confirmation, :is_admin

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name,  presence: true
end
