class UserPasswordEditType < User
  include BasicType

  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true

end
