class Admin::UserCreateType < User
  include BasicType

  permit :state_event, :admin, :role, :topic_ids,
         :email, :last_name, :first_name, :city, :password, :password_confirmation

  validates :email, presence: true
end
