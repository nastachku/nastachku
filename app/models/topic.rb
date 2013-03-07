class Topic < ActiveRecord::Base
  include TopicRepository

  attr_accessible :description, :title

  validates :title, presence: true
  validates :description, presence: true

  has_many :users, through: :user_topics
  has_many :user_topics

  audit :title, :description

  def to_s
    title
  end
end
