class UserLecturesEditType < User
  include BasicType

  accepts_nested_attributes_for :lectures #, reject_if: :all_blank

  permit :photo, :about,
    lectures_attributes: [:id, :_destroy, :title, :thesises, :workshop_id, :presentation, :user_id]

  validates :photo, presence: true
  validates :about, presence: true

  validates_associated :lectures
end
