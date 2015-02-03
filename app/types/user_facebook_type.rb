class UserFacebookType < User
  include BasicType

  has_secure_password validations: false

  permit :email, :first_name, :last_name, :photo, :facebook

  def initialize(attributes = nil, options = {})
    super(attributes, options)
    self.password = SecureRandom.urlsafe_base64
  end
end
