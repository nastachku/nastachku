class ActivateTicketCode
  def self.call(user, code, cookies = {})
    # NOTE: refactor me, please
    user.transaction do
      case code.kind
      when 'conference'
        user.ticket = Ticket.create_with(price: code.price).find_or_create_by!(ticket_code: code)
        GoogleAnalyticsClient.conference_code_activation_event(user, cookies)
      when 'party'
        user.afterparty_ticket = AfterpartyTicket.create_with(price: code.price).find_or_create_by!(ticket_code: code)
        GoogleAnalyticsClient.party_code_activation_event(user, cookies)
      end

      code.activate!
    end
  end
end
