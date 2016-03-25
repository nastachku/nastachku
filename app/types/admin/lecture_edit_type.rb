class Admin::LectureEditType < Lecture
  include BasicType

  permit :state_event, :user_id, :thesises, :workshop_id, :title, :presentation, :notes, :move_to_top

  validates :thesises, presence: true
end
