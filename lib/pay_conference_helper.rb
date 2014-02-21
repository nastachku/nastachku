module PayConferenceHelper
  def update_user_pay_conference_state(user)
    if (user.ticket_orders & TicketOrder.with_payment_state(:paid)).any?
      user.pay_part
    end
  end
end
