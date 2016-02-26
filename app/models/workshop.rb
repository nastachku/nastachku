class Workshop < ActiveRecord::Base
  include WorkshopRepository

  attr_accessible :title, :color, :icon

  has_many :lectures

  validates :color, inclusion: { in: %w(green yellow orange blue red purple) }

  audit :title

  mount_uploader :icon, SectionIconUploader

  def to_s
    title
  end
end
