class Ticket < ActiveRecord::Base
  attr_accessible :price

  belongs_to :order
  belongs_to :user
  belongs_to :ticket_code

  scope :with_user, -> { where.not(user: nil) }
end
