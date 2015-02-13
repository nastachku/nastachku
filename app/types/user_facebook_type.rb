class UserFacebookType < User
  include BasicType

  permit :email, :first_name, :last_name, :photo, :facebook

  validates :email, presence: true

  def initialize(attributes = nil, options = {})
    super(attributes, options)
    self.password = SecureRandom.urlsafe_base64
  end
end
