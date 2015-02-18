class Admin::TicketCodeCreateType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model

  attribute :count, Integer
  attribute :category, String
  attribute :propagator_id, Integer

  validates :category, presence: true
  validates :count, presence: true,
                    numericality: { greater_than: 0 }

  def persisted?
    false
  end
end
