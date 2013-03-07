class Hall < ActiveRecord::Base
  include HallRepository
  
  attr_accessible :title
  
  validates :title, presence: true

  audit :title

  has_many :events, class_name: :BaseEvent

  def to_s
    title
  end
end
