class ActivateTicket
  class << self
    def call(user, ticket_code)
      ticket_code.activate!

      order = user.ticket_orders
                  .create(
                    cost: ticket_code.price,
                    transaction_id: ticket_code.code,
                    payment_system: 'paper_ticket',
                    items_count: 1
                  )

      order.pay!
    end
  end
end
