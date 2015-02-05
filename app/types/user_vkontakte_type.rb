class UserVkontakteType < User
  include BasicType

  has_secure_password validations: false

  permit :email, :first_name, :last_name, :photo, :vkontakte

  validates :email, presence: true

  def initialize(attributes = nil, options = {})
    super(attributes, options)
    self.password = SecureRandom.urlsafe_base64
  end
end
