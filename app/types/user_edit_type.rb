
class UserEditType < User
  include BasicType

  attr_accessible :password_confirmation

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name,  presence: true

  validates :password, presence: true
  validates :password_confirmation, presence: true
end
