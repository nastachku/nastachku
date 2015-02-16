class UserPasswordRemindType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model

  attribute :email, String

  validates :email, presence: true, email: true

  validates_each :email do |record, attr, value|
    user = record.user

    unless user
      record.errors.add(attr, I18n.t('activemodel.errors.models.user_password_remind_type.attributes.email.user_should_not_exists'))
    end

    if user && user.inactive?
      record.errors.add(attr, I18n.t('activemodel.errors.models.user_password_remind_type.attributes.email.user_inactive'))
    end
  end

  def persisted?
    false
  end

  def user
    @user ||= User.find_by_email(email)
  end
end
