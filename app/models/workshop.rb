class Workshop < ActiveRecord::Base
  include WorkshopRepository

  attr_accessible :title, :color

  has_many :lectures
  #has_many :user_events

  audit :title

  def to_s
    title
  end
end
