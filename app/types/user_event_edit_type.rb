class UserEventEditType < User
  include BasicType
  
  validates :photo, presence: true
  validates :about, presence: true

  validates_associated :events

  attr_accessor :events_attributes

  accepts_nested_attributes_for :events #, reject_if: :all_blank
  
end
