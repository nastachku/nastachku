class Admin::UserEditType < User
  include BasicType

  attr_accessible :password_confirmation, :state_event

  validates :first_name,  presence: true
  validates :last_name,  presence: true

end