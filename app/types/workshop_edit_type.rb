class WorkshopEditType < Workshop
  include BasicType

  permit :title, :color, :icon

  validates :title, presence: true, length: { maximum: 255 }
  validates :color, presence: true, length: { maximum: 255 }
end
