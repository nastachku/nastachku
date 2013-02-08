class UserEvent < BaseEvent
  attr_accessible :speaker_id
  
  belongs_to :speaker, class_name: 'User'
end