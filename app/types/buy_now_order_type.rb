class BuyNowOrderType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model

  attribute :tickets, Integer
  attribute :afterparty_tickets, Integer
  attribute :name, String
  attribute :phone, String
  attribute :email, String
  attribute :payment_system, String

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :tickets, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :afterparty_tickets, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :payment_system, presence: true
  validate :buys_at_least_one_ticket

  attr_reader :errors

  def initialize(*args)
    @errors = ActiveModel::Errors.new(self)
    super(*args)
  end

  def persisted?
    false
  end

  def to_hash
    {
      name: name,
      phone: phone,
      email: email
    }
  end

  private
  def buys_at_least_one_ticket
    errors.add(:base, :at_least_one_ticket_should_be_bought) if tickets.zero? && afterparty_tickets.zero?
  end
end
