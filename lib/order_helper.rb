module OrderHelper
  def pay_user_if_ticket(order)
    if order.type == "TicketOrder"
      order.user.pay_part
    end
  end

  def ticket_order_one_of_two_items?(order, order_cost)
    order.its_cost == configus.platidoma.ticket_price and order_cost - configus.platidoma.ticket_price == configus.platidoma.afterparty_price
  end

  def afterparty_one_of_two_items?(order, order_cost)
    (order.its_cost == configus.platidoma.afterparty_price and order_cost - configus.platidoma.afterparty_price == configus.platidoma.ticket_price)
  end

  def put_paid_status_with_other_orders(order)
    order_cost = order.cost
    order.user.orders.each do |other_order|
      if order == other_order or not other_order.type
        next
      end
      if order.decorate.in_same_minute_with? other_order
        if order_cost == other_order.its_cost
          pay_user_if_ticket other_order
          other_order.pay
          break;
        elsif order_cost > other_order.its_cost
          if ticket_order_one_of_two_items?(other_order, order_cost) or afterparty_one_of_two_items?(other_order, order_cost)
            pay_user_if_ticket other_order
            other_order.pay
            order_cost -= other_order.its_cost
          end
        end
      end
    end
  end
end
