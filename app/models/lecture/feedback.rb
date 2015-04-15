class Lecture::Feedback < ActiveRecord::Base
  belongs_to :user
  belongs_to :lecture

  validates :user, presence: true
  validates :lecture, presence: true
  validates :vote, presence: true, inclusion: { in: [1, 2, 3, 4, 5] }

  attr_accessible :user
end
