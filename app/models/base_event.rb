class BaseEvent < ActiveRecord::Base
  include EventRepository

  attr_accessible :presentation, :thesises, :title, :start_time, :finish_time, :workshop_id, :hall_id, :votings_count

  validates :title, presence: true

  mount_uploader :presentation, EventPresentationUploader

  belongs_to :workshop
  belongs_to :hall
  
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
