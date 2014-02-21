module Web::AccountsHelper
  def user_has_no_tickets?(user)
    user.ticket_orders.empty?
  end

  def user_has_paid_ticket?(user)
    (user.ticket_orders & TicketOrder.with_payment_state(:paid)).any?
  end
end
