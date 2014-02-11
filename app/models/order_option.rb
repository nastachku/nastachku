class OrderOption < ActiveRecord::Base
  attr_accessible :cost, :ticket_orders_attributes, :shirt_orders_attributes

  has_many :ticket_orders
  has_many :shirt_orders
  accepts_nested_attributes_for :ticket_orders
  accepts_nested_attributes_for :shirt_orders

  validates :cost, presence: true
end
