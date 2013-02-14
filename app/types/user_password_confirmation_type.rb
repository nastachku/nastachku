class UserPasswordConfirmationType < User
  include BasicType

  attr_accessible :password, :password_confirmation

  validates :password, presence: true, confirmation: true
end