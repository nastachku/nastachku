class Event::Break < BaseEvent
  attr_accessible :title, :start_time, :finish_time, :workshop_id, :hall_id, :state_event

  validates :title, presence: true
  validates :start_time, presence: true
  validates :finish_time, presence: true
  validates :hall, presence: true
end