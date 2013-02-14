class UserPasswordEditType < User
  include BasicType

  validates :password, :presence => true, :confirmation => true

end