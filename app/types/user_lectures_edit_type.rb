class UserLecturesEditType < User
  include BasicType

  validates :photo, presence: true

  validates_associated :lectures

  attr_accessor :lectures_attributes

  accepts_nested_attributes_for :lectures #, reject_if: :all_blank

end
