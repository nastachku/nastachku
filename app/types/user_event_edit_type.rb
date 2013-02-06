class UserEventEditType < User
  include BasicType

  validates :photo, presence: true
  validates :about, presence: true
end
