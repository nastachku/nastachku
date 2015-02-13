class UserVkontakteType < User
  include BasicType

  permit :email, :first_name, :last_name, :photo, :vkontakte

  def initialize(attributes = nil, options = {})
    super(attributes, options)
    self.password = SecureRandom.urlsafe_base64
  end
end
