class UserTopic < ActiveRecord::Base
  attr_accessible :topic_id, :user_id

  belongs_to :user
  belongs_to :topic
end
