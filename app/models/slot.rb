class Slot < ActiveRecord::Base
  include SlotRepository
  include UsefullScopes
  extend Enumerize

  class << self
    def available_events
      [ "Lecture", "Event" ]
    end
  end

  attr_accessible :event_id, :event_type, :finish_time, :hall_id, :start_time

  belongs_to :hall, touch: true
  belongs_to :event, polymorphic: true, touch: true

  enumerize :event_type, in: [ :Lecture, :Event ]

  validates :start_time, presence: true
  validates :finish_time, presence: true
  validates :event_id, presence: true
  validates :event, presence: true
end
