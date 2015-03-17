class Admin::EventEditType < Event
  include BasicType

  permit :state_event, :title, :description, :color, :show_voting, :user_id, :url

  validates :title, presence: true
end
