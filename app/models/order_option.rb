class OrderOption < ActiveRecord::Base
  attr_accessible :cost, :ticket_order_attributes, :shirt_order_attributes

  has_many :ticket_orders
  has_many :shirt_orders
  accepts_nested_attributes_for :ticket_orders
  accepts_nested_attributes_for :shirt_orders

  validates :cost, presence: true
end
