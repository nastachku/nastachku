class UserEvent < BaseEvent
  attr_accessible :speaker_id, :state_event, :listener_votings_count, :lecture_votings_count

  validates :title, presence: true
  validates :thesises, presence: true

  belongs_to :speaker, class_name: 'User'
  has_many :listener_votings, as: :voteable
  has_many :lecture_votings, as: :voteable
end