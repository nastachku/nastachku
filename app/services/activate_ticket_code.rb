class ActivateTicketCode
  def self.call(user, code)
    # NOTE: refactor me
    user.transaction do
      case code.kind
      when 'conference'
        user.ticket = Ticket.create_with(price: code.price).find_or_create_by!(ticket_code: code)
      when 'party'
        user.afterparty_ticket = AfterpartyTicket.create_with(price: code.price).find_or_create_by!(ticket_code: code)
      end

      code.activate!
    end
  end
end
