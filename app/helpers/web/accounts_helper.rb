module Web::AccountsHelper
  def first_day_and_both
    [TicketOrder.ticket_type.values.first, TicketOrder.ticket_type.values.last]
  end

  def second_day_and_both
    [TicketOrder.ticket_type.values.second, TicketOrder.ticket_type.values.last]
  end

  def user_has_not_tickets(user)
    user.ticket_orders.empty?
  end

  def user_has_bought_full_ticket?(user)
    user.ticket_orders.any? { |t| t.ticket_type.full? }
  end

  def user_has_first_day?(user)
    user.ticket_orders.any? { |t| t.ticket_type.first? }
  end

  def user_has_second_day?(user)
    user.ticket_orders.any? { |t| t.ticket_type.second? }
  end

  def user_has_bought_first_and_second_days_tickets?(user)
    if user_has_first_day? user
      user_has_second_day? user
    end
  end

  def user_has_full_ticket?(user)
    user_has_bought_full_ticket?(user) or user_has_bought_first_and_second_days_tickets?(user)
  end
end
