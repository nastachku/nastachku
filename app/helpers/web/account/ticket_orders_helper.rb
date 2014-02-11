module Web::Account::TicketOrdersHelper
<<<<<<< HEAD
=======
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
>>>>>>> 940c36cc6eab2279d083dac39d5d976c4827fac5
end
