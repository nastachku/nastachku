class TicketCodeActivationType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model

  attribute :code, String
  attribute :current_user, Object

  validates :code, presence: true

  validates_each :code do |record, attr, value|
    ticket_code = record.ticket_code
    user = record.user

    if !ticket_code
      record.errors.add(attr, :code_not_exist)
    end

    if ticket_code.try(:active?)
      record.errors.add(attr, :code_activated)
    end

    # FIXME
    if ticket_code && ticket_code.kind == 'conference' && user.ticket
      record.errors.add(attr, :ticket_already_exists)
    end

    if ticket_code && ticket_code.kind == 'party' && user.afterparty_ticket
      record.errors.add(attr, :afterparty_ticket_already_exists)
    end
  end

  # FIXME
  def user
    @user = current_user
  end

  def ticket_code
    @ticket_code ||= TicketCode.find_by(code: code.downcase)
  end

  def persisted?
    false
  end
end
