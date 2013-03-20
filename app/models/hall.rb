class Hall < ActiveRecord::Base
  include HallRepository
  
  attr_accessible :title, :slots_attributes
  
  validates :title, presence: true
  validates_associated :slots

  has_many :events, class_name: :BaseEvent, through: :slots
  has_many :slots, order: :start_time

  accepts_nested_attributes_for :slots, allow_destroy: true

  audit :title

  def to_s
    title
  end
end
