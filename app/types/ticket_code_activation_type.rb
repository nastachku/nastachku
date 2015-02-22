class TicketCodeActivationType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model

  attribute :code, String

  validates :code, presence: true

  validates_each :code do |record, attr, value|
    ticket_code = record.ticket_code

    if !ticket_code
      record.errors.add(attr, :code_not_exist)
    end

    if ticket_code.try(:active?)
      record.errors.add(attr, :code_activated)
    end
  end

  def ticket_code
    @ticket_code ||= TicketCode.find_by(code: code.downcase)
  end

  def persisted?
    false
  end
end
