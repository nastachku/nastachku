class Admin::EventEditType < Event
  include BasicType

  permit :state_event, :title, :description, :color, :show_voting, :user_id

  validates :title, presence: true
end
