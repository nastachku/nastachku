class Admin::LectureEditType < Lecture
  include BasicType

  attr_accessible :state_event, :user_id

  validates :thesises, presence: true
  validates :user, presence: true
end