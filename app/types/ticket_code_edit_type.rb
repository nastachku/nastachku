class TicketCodeEditType < TicketCode
  include BasicType

  validates :code, presence: true

  validates_each :code do |record, attr, value|
    ticket_code = record

    if ticket_code && ticket_code.try(:activated?)
      record.errors.add(attr, :code_activated)
    end
  end
end
