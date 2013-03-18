class Event < ActiveRecord::Base
  include EventRepository

  attr_accessible :title, :state_event, :state

  validates :title, presence: true

  has_many :slots, as: :event
  has_many :halls, through: :slots

  state_machine initial: :inactive do
    state :inactive
    state :active

    event :activate do
      transition :inactive => :active
    end

    event :deactivate do
      transition :active => :inactive
    end
  end
end
