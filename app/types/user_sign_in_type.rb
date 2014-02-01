class UserSignInType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus

  attribute :email, String
  attribute :password, String

  validates :email, presence: true, email: true
  validates :password, presence: true

  validates_each :email do |record, attr, value|
    user = record.user
    if user.try :new?
      record.errors.add(attr, :user_new)
    end

    if user.try :inactive?
      record.errors.add(attr, :user_inactive)
    end

    if !user.try(:authenticate, record.password)
      record.errors.add(attr, :user_or_password_invalid)
    end
  end

  def persisted?
    false
  end

  def user
    @user ||= User.find_by_email(email.mb_chars.downcase)
  end
end
