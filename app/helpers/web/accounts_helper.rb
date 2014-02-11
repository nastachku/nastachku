module Web::AccountsHelper
  def ticket_type_collection
    TicketOrder.ticket_type.values
  end

  def item_size_collection
    ShirtOrder.item_size.values
  end

  def item_color_collection
    ShirtOrder.item_color.values
  end

  def user_has_bought_full_ticket?(user)
    user.ticket_orders.any? { |t| t.ticket_type.full? }
  end

  def user_has_bought_first_and_second_days_tickets?(user)
    if user.ticket_orders.any? { |t| t.ticket_type.first_day? }
      user.ticket_orders.any? { |t| t.ticket_type.second_day? }
    end
  end

  def user_has_full_ticket?(user)
    user_has_bought_full_ticket?(user) or user_has_bought_first_and_second_days_tickets?(user)
  end
end
