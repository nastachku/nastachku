class Hall < ActiveRecord::Base
  include HallRepository

  attr_accessible :title, :slots_attributes, :state_event

  validates :title, presence: true
  validates_associated :slots

  has_many :slots, -> { order :start_time }

  accepts_nested_attributes_for :slots, allow_destroy: true

  state_machine :state, initial: :new do
    state :new
    state :active
    state :inactive

    event :activate do
      transition [:inactive, :new] => :active
    end

    event :deactivate do
      transition [:active, :new] => :inactive
    end
  end

  audit :title
end
