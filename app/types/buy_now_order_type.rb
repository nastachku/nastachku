class BuyNowOrderType
  include ActiveModel::Validations
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

  def payment_system_collection
    %w(payanyway platidoma).map do |system|
      [I18n.t("web.payment_systems.#{system}"), system]
    end
  end

  def persisted?
    false
  end
end
