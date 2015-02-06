class News < ActiveRecord::Base
  include NewsRepository

  attr_accessible :body, :slug, :title

  validates :slug,  presence: true, uniqueness: true
  validates :title, presence: true
  validates :body,  presence: true

  audit :title, :body, :slug
end
