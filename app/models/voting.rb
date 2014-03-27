class Voting < ActiveRecord::Base
  attr_accessible :voteable, :voteable_id, :user_id, :user

  belongs_to :user
  belongs_to :voteable, polymorphic: true, touch: true
end
