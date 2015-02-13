class UserTwitterType < User
  include BasicType

  permit :first_name, :last_name, :photo, :twitter_name

  def initialize(attributes = nil, options = {})
    super(attributes, options)
    self.password = SecureRandom.urlsafe_base64
  end
end
