class Workshop < ActiveRecord::Base
  attr_accessible :title

  has_many :events, class_name: :BaseEvent
end
