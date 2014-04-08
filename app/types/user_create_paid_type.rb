class UserCreatePaidType < User
  include BasicType

  validates :first_name, presence: true
  validates :email, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
end
