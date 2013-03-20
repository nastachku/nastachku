class Event::Break < BaseEvent
  attr_accessible :title, :workshop_id, :state_event

  validates :title, presence: true

  has_many :slots, as: :event
  has_many :halls, through: :slots
end