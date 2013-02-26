class Admin::UserEditType < User
  include BasicType

  attr_accessible :state_event, :admin, :role, :topic_ids

  validates :first_name,  presence: true
  validates :last_name,  presence: true
  validates :city, presence: true
  #validates :password

end