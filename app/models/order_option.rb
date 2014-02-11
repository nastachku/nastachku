class OrderOption < ActiveRecord::Base
  attr_accessible :cost, :ticket_order_attributes, :shirt_order_attributes

  has_one :ticket_order
  has_one :shirt_order
  accepts_nested_attributes_for :ticket_order
  accepts_nested_attributes_for :shirt_order

  validates :cost, presence: true
end
