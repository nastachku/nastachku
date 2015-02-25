class AfterpartyTicket < ActiveRecord::Base
  attr_accessible :price

  belongs_to :user
  belongs_to :order

  scope :with_user, -> { where.not(user: nil) }
end
