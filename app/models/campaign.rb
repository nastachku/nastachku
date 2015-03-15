class Campaign < ActiveRecord::Base
  attr_accessible :name, :tickets_count, :afterparty_tickets_count, :start_date, :end_date, :discount_amount

  has_many :orders

  validates :name, presence: true
  validates :tickets_count, numericality: { greater_than: 0, only_integer: true }, allow_blank: true
  validates :afterparty_tickets_count, numericality: { greater_than: 0, only_integer: true }, allow_blank: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :discount_amount, presence: true, numericality: { only_integer: true }

  validate :collision_date, :correct_date_range

  def collision_date
    query = self.class.in_range(start_date, end_date)
    query = query.where('id != ?', id) unless new_record?
    if query.any?
      errors.add(:start_date, :date_collision)
      errors.add(:end_date, :date_collision)
    end
  end

  def correct_date_range
    if start_date > end_date
      errors.add(:start_date, :invalid_date_range)
      errors.add(:end_date, :invalid_date_range)
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
end
