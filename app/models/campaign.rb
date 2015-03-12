class Campaign < ActiveRecord::Base
  attr_accessible :name, :tickets_count, :afterparty_tickets_count, :start_date, :end_date, :discount_amount

  has_many :orders

  validates :name, presence: true
  validates :tickets_count, numericality: { greater_than: 0, only_integer: true }, allow_blank: true
  validates :afterparty_tickets_count, numericality: { greater_than: 0, only_integer: true }, allow_blank: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :discount_amount, presence: true, numericality: { only_integer: true }

  validates_each :start_date, :end_date do |record, attr, value|
    if self.in_range(record[:start_date], record[:end_date]).where('id != ?', record[:id]).any?
      record.errors.add(attr, :date_collision)
    end
  end

  scope :in_range, ->(start_date, end_date) { where(":sd <= end_date AND :ed >= start_date", sd: start_date, ed: end_date) }

  def self.suitable_for(tickets_count, afterparty_count, date)
    where(
      "(campaigns.tickets_count <= :tc OR campaigns.tickets_count IS NULL)
      AND
      (campaigns.afterparty_tickets_count <= :atc OR campaigns.afterparty_tickets_count IS NULL)
      AND
      :date BETWEEN campaigns.start_date AND campaigns.end_date",
      tc: tickets_count,
      atc: afterparty_count,
      date: date
    ).first
  end

  def with_discount(cost)
    cost - discount_amount
  end
end
