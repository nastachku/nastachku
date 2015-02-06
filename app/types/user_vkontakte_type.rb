class UserVkontakteType < User
  include BasicType

  permit :email, :first_name, :last_name, :photo, :vkontakte

  validates :email, presence: true
end
