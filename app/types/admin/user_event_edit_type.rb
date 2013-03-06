class Admin::UserEventEditType < UserEvent
  include BasicType

  validates :title, presence: true
  validates :thesises, presence: true
end