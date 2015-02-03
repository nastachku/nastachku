class Admin::TopicEditType < Topic
  include BasicType

  permit :title, :description
end
