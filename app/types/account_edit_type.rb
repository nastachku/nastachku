class AccountEditType < User
  include BasicType

  attr_accessor :old_password
  attr_accessible :state_event, :old_password

  validates :first_name,  presence: true
  validates :last_name,  presence: true
  validates :city, presence: true
  validates_each :old_password do |record, attr, value|
    if !value.empty? and !User.find(record.id).authenticate(value)
      record.errors.add(attr, I18n.t(:password_is_wrong, scope: [:activerecord, :errors, :messages]))
    end
  end

  def city=(city)
    write_attribute(:city, city.mb_chars.downcase)
  end

end
