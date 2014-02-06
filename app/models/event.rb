class Event < ActiveRecord::Base
  include EventRepository

  attr_accessible :title, :state_event, :description, :color, :user_ids, :event_votings_count,
    :show_voting

  validates :title, presence: true

  has_many :slots, as: :event
  has_many :halls, through: :slots
  has_many :event_users
  has_many :users, through: :event_users
  has_many :event_votings, as: :voteable, extend: [Extensions::VotingExtension]

  state_machine initial: :inactive do
    state :inactive
    state :active

    event :activate do
      transition inactive: :active
    end

    event :deactivate do
      transition active: :inactive
    end
  end

end
