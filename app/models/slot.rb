class Slot < ActiveRecord::Base
  include SlotRepository

  attr_accessible :event_id, :finish_time, :hall_id, :start_time

  belongs_to :hall
  belongs_to :event, class_name: :BaseEvent

  validates :start_time, presence: true
  validates :finish_time, presence: true
  #validates :event, presence: true
  validates :event_id, presence: true

  def start_hour
    start_time.hour
  end

  def start_offset
    start_time.min
  end

  def duration
    (finish_time - start_time).to_int / 60
  end
end
