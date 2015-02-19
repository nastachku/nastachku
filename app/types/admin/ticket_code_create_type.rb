class Admin::TicketCodeCreateType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model

  attribute :count, Integer
  attribute :price, Integer
  attribute :category, String
  attribute :distributor_id, Integer

  validates :category, presence: true
  validates :price, presence: true
  validates :distributor_id, presence: true
  validates :count, presence: true,
                    numericality: { greater_than: 0 }

  def persisted?
    false
  end
end
