class User::PromoCode < ActiveRecord::Base
  attr_accessible :accepted, :code, :user_id

  belongs_to :user

  validates :code, presence: true
  validates :accepted, presence: true, default: false
  validates :user_id, presence: true
end
