class Admin::TopicEditType < Topic
  include BasicType

  validates :title, presence: true
  validates :description, presence: true
end