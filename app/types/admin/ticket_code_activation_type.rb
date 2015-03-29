class Admin::TicketCodeActivationType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model

  attribute :id, Integer
  attribute :user_id, Integer
  attribute :ticket_code, TicketCode

  def activate!
    user = User.find(user_id)
    case ticket_code.kind
    when 'party'
      if user.afterparty_ticket
        errors.add(:user_id, :user_already_has_ticket)
        return false
      end
      ticket = AfterpartyTicket.new
    when 'conference'
      if user.ticket
        errors.add(:user_id, :user_already_has_ticket)
        return false
      end
      ticket = Ticket.new
    end

    ticket.user = user
    ticket.ticket_code = ticket_code
    ticket.price = ticket_code.price
    ticket.save && ticket_code.activate
  end
end
