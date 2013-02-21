class News < ActiveRecord::Base
  include NewsRepository

  attr_accessible :body, :slug, :title

  audit :title, :body, :slug
end
