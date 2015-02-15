class AccountEditType < User
  include BasicType

  attr_accessor :old_password
  attr_accessible :state_event, :old_password

  validates :first_name,  presence: true
  validates :last_name,  presence: true
  validates_each :old_password do |record, attr, value|
    @old_password_is_present = value.present?
    if @old_password_is_present && !User.find(record.id).authenticate(value)
      record.errors.add(attr, I18n.t(:password_is_wrong, scope: [:activerecord, :errors, :messages]))
    end
  end
  validates_each :password do |record, attr, value|
    if @old_password_is_present && value.blank?
      record.errors.add(attr, I18n.t(:password_not_valid, scope: [:activerecord, :errors, :messages]))
    end
  end

  permit :first_name, :last_name, :email, :city, :old_password,
         :password, :state_event, :photo,
         :twitter_name, :vkontakte, :facebook, :company, :position,
         :show_as_participant

  def city=(city)
    write_attribute(:city, city.mb_chars.downcase)
  end

end
