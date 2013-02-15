class News < ActiveRecord::Base
  include NewsRepository

  attr_accessible :body, :slug, :title
end
