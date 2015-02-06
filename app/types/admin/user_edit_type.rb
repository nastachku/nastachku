class Admin::UserEditType < User
  include BasicType

  permit :state_event, :admin, :role, :topic_ids,
         :email, :last_name, :first_name, :city


  validates :email, presence: true
end
