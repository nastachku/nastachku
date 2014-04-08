class Discount < ActiveRecord::Base
  attr_accessible :begin_date, :code, :end_date, :cost

  has_many :order
  validates :begin_date, presence: true
  validates :end_date, presence: true
  validates :code, presence: true
  validates :cost, presence: true
end
