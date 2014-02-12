class UserPasswordConfirmationType < User
  include BasicType

  attr_accessible :password, :password_confirmation

  #validates_each :password do |record, attr, value|
  #  unless value =~ /^.{8,30}$/ and value =~ /^.*[a-z]+.*$/ and
  #      value =~ /^.*[A-Z]+.*$/ and value =~ /^.*[0-9]+.*$/ and
  #      value =~ /^.*[`~!@#$%^&*()_+=\-{}\[\]\/\\|;:,.?<>-]+.*$/
  #    record.errors.add(attr, I18n.t(:password_not_valid, scope: [:activerecord, :errors, :messages]))
  #  end
  #end
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
end
