class UserEvent < BaseEvent
  attr_accessible :speaker_id, :state_event, :listener_votings_count, :lecture_votings_count

  validates :title, presence: true
  validates :thesises, presence: true

  belongs_to :speaker, class_name: 'User'
  has_many :listener_votings, as: :voteable, extend: [Extensions::VotingExtension]
  has_many :lecture_votings, as: :voteable, extend: [Extensions::VotingExtension]
  has_many :listeners, through: :listener_votings, source: :user
  has_many :voted, through: :lecture_votings, source: :user
end