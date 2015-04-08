class UserStubType < User
  include BasicType

  permit :first_name, :last_name, :email

  def initialize(attributes = nil, options = {})
    super(attributes, options)
    p self
    self.password = SecureRandom.urlsafe_base64
    self.state = 'active'
  end
end
