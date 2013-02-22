class UserRegistrationType < User
  include BasicType

  attr_accessible :password_confirmation, :state_event, :process_personal_data

  #has_secure_password

  validates :first_name,  presence: true
  validates :last_name,  presence: true
  validates :city, presence: true
  validates :password, presence: true, confirmation: true
  validates :process_personal_data, acceptance: true

  def city=(city)
    write_attribute(:city, city.mb_chars.downcase)
  end

end