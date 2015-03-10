class Campaign < ActiveRecord::Base
  attr_accessible :name, :tickets_count, :afterparty_tickets_count, :start_date, :end_date, :discount_amount

  belongs_to :order

  validates :name, presence: true
  validates :tickets_count, numericality: { greater_than: 0, only_integer: true }, allow_blank: true
  validates :afterparty_tickets_count, numericality: { greater_than: 0, only_integer: true }, allow_blank: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :discount_amount, presence: true, numericality: { only_integer: true }
end
