class Slot < ActiveRecord::Base
  include SlotRepository
  include UsefullScopes
  extend Enumerize

  attr_accessible :event_id, :finish_time, :hall_id, :start_time #, :event_type

  belongs_to :hall, touch: true
  belongs_to :event, polymorphic: true, touch: true

  # enumerize :event_type, in: [:Lecture, :Event]

  validates :start_time, presence: true
  validates :finish_time, presence: true
  validates :event_id, presence: true
  validates :event, presence: true
end
