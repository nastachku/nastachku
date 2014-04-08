class UserCreatePaidType < User
  include BasicType

  validates :email, presence: false
  validates :city, presence: false
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
end
