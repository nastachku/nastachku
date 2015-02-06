class Page < ActiveRecord::Base
  include PageRepository

  attr_accessible :body, :slug, :title

  validates :slug,  presence: true, uniqueness: true
  validates :body,  presence: true

  audit :title, :body

  def to_s
    title
  end
end
