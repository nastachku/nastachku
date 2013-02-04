class UserEditType < User
  include BasicType

  attr_accessible :password_confirmation, :state_event

  validates :email, presence: true, uniqueness: true
  validates :name,  presence: true
  
end