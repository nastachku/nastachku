class UserRegistrationType < User
  include BasicType

  attr_accessible :password_confirmation, :state_event, :process_personal_data

  #has_secure_password

  validates :first_name,  presence: true
  validates :last_name,  presence: true
  validates :city, presence: true
  #validates_each :password do |record, attr, value|
  #  unless value =~ /^.{8,30}$/ and value =~ /^.*[a-z]+.*$/ and
  #      value =~ /^.*[A-Z]+.*$/ and value =~ /^.*[0-9]+.*$/ and
  #      value =~ /^.*[`~!@#$%^&*()_+=\-{}\[\]\/\\|;:,.?<>-]+.*$/
  #    record.errors.add(attr, I18n.t(:password_not_valid, scope: [:activerecord, :errors, :messages]))
  #  end
  #end
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  validates :process_personal_data, acceptance: true

  def city=(city)
    write_attribute(:city, city.mb_chars.downcase)
  end

  def email=(email)
    write_attribute(:email, email.mb_chars.downcase)
  end

end
