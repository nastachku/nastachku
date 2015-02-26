class BuyNowOrderType
  include ActiveModel::Validations
  include Virtus.model

  attribute :tickets, Integer
  attribute :afterparty_tickets, Integer
  attribute :type, String
  attribute :name, String
  attribute :phone, String
  attribute :email, String
  attribute :inn, String

  validates :name, presence: true
  validates :type, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :inn, presence: true
  validates :tickets, numericality: true, presence: true
  validates :afterparty_tickets, numericality: true, presence: true

  def persisted?
    false
  end
end
