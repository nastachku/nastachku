class UserEventEditType < User
  include BasicType
  
  validates :photo, presence: true
  validates :about, presence: true
  
  accepts_nested_attributes_for :events #, reject_if: :all_blank, allow_destroy: true
  
end
