class Page < ActiveRecord::Base
  include PageRepository

  attr_accessible :body, :slug, :title
end
