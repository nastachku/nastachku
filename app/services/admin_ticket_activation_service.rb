class AdminTicketActivationService
  def initialize(user)
    @user = user
  end

  def activate_code(code)
    ticket_code = TicketCode.can_activate.find_by(code: code)
    case ticket_code.kind
    when "conference"
      if @user.ticket.present?
        @user.ticket.cancel
      end
      ticket = @user.build_ticket
    when "party"
      if @user.afterparty_ticket.present?
        @user.afterparty_ticket.cancel
      end
      ticket = @user.build_afterparty_ticket
    end

    ticket_code.activate
    ticket.ticket_code = ticket_code
    ticket.price = ticket_code.price
    ticket.save
  end
end
