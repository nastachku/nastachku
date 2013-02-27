class UserPasswordConfirmationType < User
  include BasicType

  attr_accessible :password, :password_confirmation

  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
end