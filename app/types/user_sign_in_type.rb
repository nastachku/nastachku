class UserSignInType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model

  attribute :email, String
  attribute :password, String

  validates :email, presence: true, email: true
  validates :password, presence: true
  validate :check_authenticate, if: :email

  validates_each :email do |record, attr, value|
    user = record.user
    if user.try :new?
      record.errors.add(attr, :user_new)
    end

    if user.try :inactive?
      record.errors.add(attr, :user_inactive)
    end
  end

  def persisted?
    false
  end

  def user
    @user ||= User.find_by(email: email.mb_chars.downcase)
  end

  def check_authenticate
    if !user.try(:authenticate, password)
      errors.add(:email, :user_or_password_invalid)
    end
  end
end
