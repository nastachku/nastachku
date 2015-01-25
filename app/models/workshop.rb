class Workshop < ActiveRecord::Base
  include WorkshopRepository

  attr_accessible :title, :color, :icon

  has_many :lectures

  audit :title

  mount_uploader :icon, SectionIconUploader

  def to_s
    title
  end
end
