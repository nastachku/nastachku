class Admin::LectureEditType < Lecture
  include BasicType

  permit :state_event, :user_id, :thesises, :workshop_id, :title, :presentation, :notes

  validates :thesises, presence: true
end
