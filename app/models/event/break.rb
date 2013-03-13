class Event::Break < BaseEvent
  attr_accessible :title, :workshop_id, :state_event

  validates :title, presence: true
end