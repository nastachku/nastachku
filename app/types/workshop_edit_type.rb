class WorkshopEditType < Workshop
  include BasicType

  validates :title, presence: true
end