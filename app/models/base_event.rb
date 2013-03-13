class BaseEvent < ActiveRecord::Base
  include EventRepository

  attr_accessible :presentation, :thesises, :title, :workshop_id,
                  :listener_votings_count, :lecture_votings_count, :type

  validates :title, presence: true
  has_many :slots, class_name: :BaseEvent
  has_many :halls, through: :slots
  belongs_to :workshop

  mount_uploader :presentation, EventPresentationUploader

  audit :title, :thesises, :thesises, :workshop

  state_machine :state, initial: :new do
    state :new
    state :in_schedule
    state :voted
    state :rejected

    event :move_to_schedule do
      transition [:new, :voted] => :in_schedule
    end
    
    event :move_to_voting do
      transition :new => :voted
    end

    event :reject do
      transition [:new, :in_schedule, :voted] => :rejected
    end
  end

  def to_s
    title
  end
end
