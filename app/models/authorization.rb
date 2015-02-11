class Authorization < ActiveRecord::Base

  belongs_to :user

  attr_accessible :provider, :uid

  validates :provider, :presence => true
  validates :uid, :presence => true

end
