class Admin::EventEditType < Event
  include BasicType

  attr_accessible :state_event

  validates :title, presence: true
end
