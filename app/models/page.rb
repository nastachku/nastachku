class Page < ActiveRecord::Base
  extend Enumerize

  attr_accessible :body, :slug, :title, :layout

  validates :slug,  presence: true, uniqueness: true
  validates :body,  presence: true
  validates :layout,  presence: true

  enumerize :layout, in: [ :application, :promo ], default: :application

  def to_s
    title
  end

  scope :web, -> { by_created_at }
  scope :promo, -> { where(layout: :promo) }
  scope :application, -> { where(layout: :application) }
end
