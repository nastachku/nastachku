class UserRegistrationType < User
  include BasicType

  has_secure_password

  attr_accessible :process_personal_data

  permit :password_confirmation, :password, :state_event, :process_personal_data,
         :first_name, :last_name, :city, :company, :position, :email

  validates :city, presence: true
  validates :process_personal_data, acceptance: true
  validates :email, presence: true

  def city=(city)
    write_attribute(:city, city.mb_chars.downcase)
  end

  def email=(email)
    write_attribute(:email, email.mb_chars.downcase)
  end

end
