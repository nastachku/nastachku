class UserLecturesEditType < User
  include BasicType

  permit :photo, :about, lectures_attributes: [
    :id, :_destroy, :title, :thesises, :workshop_id, :presentation, :user_id]

  validates :photo, presence: true
  validates :about, presence: true

  validates_associated :lectures
end
