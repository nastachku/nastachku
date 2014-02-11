class OrderOption < ActiveRecord::Base
  attr_accessible :cost

  has_one :ticket_order
  has_one :shirt_order

  validates :cost, presence: true
end
