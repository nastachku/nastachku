class Admin::UserEditType < User
  include BasicType

  attr_accessible :admin, :role

  permit :state_event, :pay_state_event, :first_name, :last_name, :city, :company, :about, :in_carousel,
    :invisible_lector, :carousel_info, :position, :email, :photo, :show_as_participant, :admin, :role,
    :badge_state_event, :reason_to_give_ticket

  def email=(val)
    self[:email] = nil if val.blank?
  end
end
