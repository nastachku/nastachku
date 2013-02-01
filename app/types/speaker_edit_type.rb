class SpeakerEditType < Speaker
  include BasicType

  attr_accessible :password_confirmation, :state_event
  
  validates :email, presence: true
  validates :name,  presence: true

end