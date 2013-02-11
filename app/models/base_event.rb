class BaseEvent < ActiveRecord::Base
  include EventRepository

  attr_accessible :presentation, :thesises, :title, :start_time, :finish_time, :workshop_id

  validates :title, presence: true
  validates :thesises, presence: true
  
  mount_uploader :presentation, EventPresentationUploader

  belongs_to :workshop
  
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
end
