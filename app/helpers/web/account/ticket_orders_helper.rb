module Web::Account::TicketOrdersHelper
  def bought_day?(day)
    if current_user.ticket_orders.any?
      current_user.ticket_orders.first.day == day
    end
  end

  def bought_first_day?
    bought_day? :first
  end

  def bought_second_day?
    bought_day? :second
  end
end
