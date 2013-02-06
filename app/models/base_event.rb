class BaseEvent < ActiveRecord::Base
  include EventRepository

  attr_accessible :presentation, :speaker_id, :thesises, :title

  belongs_to :speaker, class_name: 'User'
  
  validates :speaker, presence: true
  
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
      transition all - :rejected => :rejected
    end
  end
end
