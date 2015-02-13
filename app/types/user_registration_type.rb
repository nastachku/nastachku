class UserRegistrationType < User
  include BasicType

  attr_accessible :process_personal_data, :password_confirmation

  permit :password_confirmation, :password, :state_event, :process_personal_data,
         :first_name, :last_name, :city, :company, :position, :email, :photo,
         :vkontakte, :facebook, :twitter_name

  validates :city, presence: true
  validates :process_personal_data, acceptance: true
  validates :email, presence: true
  validates :password, confirmation: true

  def email=(email)
    write_attribute(:email, email.mb_chars.downcase)
  end

end
