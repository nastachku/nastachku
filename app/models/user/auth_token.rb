class User::AuthToken < ActiveRecord::Base

  belongs_to :user

  attr_accessible :authentication_token, :expired_at

  validates :user, :presence => true
  validates :authentication_token, :presence => true, :uniqueness => true
  validates :expired_at, :presence => true

  def to_s
    authentication_token
  end

  def expired?
    expired_at < Time.current
  end
end