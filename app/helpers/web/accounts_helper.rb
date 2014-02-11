module Web::AccountsHelper
  def ticket_type_collection
    TicketOrder.ticket_type.values
  end
end
