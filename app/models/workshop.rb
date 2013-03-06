class Workshop < ActiveRecord::Base
  include WorkshopRepository

  attr_accessible :title

  has_many :events, class_name: :BaseEvent
  has_many :user_events

  def to_s
    title
  end
end
