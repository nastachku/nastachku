class Page < ActiveRecord::Base
  include PageRepository

  attr_accessible :body, :slug, :title

  audit :title, :body

  def to_s
    title
  end
end
