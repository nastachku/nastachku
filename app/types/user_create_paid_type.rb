class UserCreatePaidType < User
  include BasicType

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :company, presence: true
  validates :password, presence: true
end
