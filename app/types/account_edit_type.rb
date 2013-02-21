class AccountEditType < User
  include BasicType

  attr_accessible :password_confirmation, :state_event

  validates :first_name,  presence: true
  validates :last_name,  presence: true
  validates :city, presence: true

  def city=(city)
    write_attribute(:city, city.mb_chars.downcase)
  end

end