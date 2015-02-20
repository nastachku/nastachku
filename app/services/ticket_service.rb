class TicketService
  class << self
    def activate(ticket_code, user)
      ticket_code.activate!

      order = user.ticket_orders
                  .create(cost: ticket_code.price,
                          payment_system: 'paper_ticket',
                          items_count: 1)
      order.transaction_id = ticket_code.code

      order.pay!
    end
  end
end
