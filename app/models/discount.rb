class Discount < ActiveRecord::Base
  attr_accessible :begin_date, :code, :end_date, :percent

  validates :begin_date, presence: true
  validates :end_date, presence: true
  validates :code, presence: true, length: { is: 8 }
  validates :percent, presence: true
end
