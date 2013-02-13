class UserEvent < BaseEvent
  attr_accessible :speaker_id, :state_event
  
  belongs_to :speaker, class_name: 'User'
end