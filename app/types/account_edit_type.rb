class AccountEditType < User
  include BasicType

  attr_accessor :old_password
  attr_accessible :state_event, :old_password

  validates :first_name,  presence: true
  validates :last_name,  presence: true
  validates :email,  presence: true
  validates_each :old_password do |record, attr, value|
    @old_password_is_empty = (value.nil? or value.empty?)
    if !@old_password_is_empty and !User.find(record.id).authenticate(value)
      record.errors.add(attr, I18n.t(:password_is_wrong, scope: [:activerecord, :errors, :messages]))
    end
  end
  validates_each :password do |record, attr, value|
    unless @old_password_is_empty and (value.nil? or value.empty?)
      unless value =~ /^.{8,30}$/ and value =~ /^.*[a-z]+.*$/ and
          value =~ /^.*[A-Z]+.*$/ and value =~ /^.*[0-9]+.*$/ and
          value =~ /^.*[`~\!\@\#\$\%^&*\(\)_+=\-"{}\[\]\/\\|;:,.?<>]+.*$/
        record.errors.add(attr, I18n.t(:password_not_valid, scope: [:activerecord, :errors, :messages]))
      end
    end
  end

  permit :first_name, :last_name, :email, :city, :old_password,
         :password, :state_event, :photo,
         :twitter_name, :vkontakte, :facebook, :company, :position

  def city=(city)
    write_attribute(:city, city.mb_chars.downcase)
  end

end
