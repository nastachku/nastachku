class UserEvent < BaseEvent
  attr_accessible :speaker_id, :state_event

  validates :title, presence: true
  validates :thesises, presence: true
  validates :presentation, presence: true

  belongs_to :speaker, class_name: 'User'
  has_many :votings, foreign_key: 'event_id'
end