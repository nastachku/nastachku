class UserEditType < User
  include BasicType

  attr_accessible :password_confirmation, :state_event

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :first_name,  presence: true
  validates :last_name,  presence: true
  validates :password, :presence => true, :confirmation => true
end