module Web::AccountsHelper
  def ticket_type_collection_part(index)
    value = TicketOrder.ticket_type.values[index]
    t_value = I18n.t("enumerize.ticket_order.ticket_type.#{value}")
    [ t_value ]
  end

  def item_size_collection
    ShirtOrder.item_size.values
  end

  def item_color_collection
    ShirtOrder.item_color.values
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
