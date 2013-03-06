class Admin::EventEditType < UserEvent
  include BasicType

  validates :title, presence: true
  validates :thesises, presence: true
  validates :start_time, presence: true
  validates :finish_time, presence: true
  validates :speaker, presence: true
  validates :workshop, presence: true

end