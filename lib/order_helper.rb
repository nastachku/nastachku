module OrderHelper
  def pay_part_if_ticket_order(order)
    if other_order.type = "TicketOrder"
      other_order.user.pay_part
    end
  end
  def put_paid_status_with_other_orders(order)
    order_cost = order.cost
    order.user.orders.each do |other_order|
      if order == other_order or not other_order.type
        next
      end
      if order.decorate.in_same_minute_with?(other_order)
        if order_cost == other_order.its_cost
          other_order.pay
          pay_part_if_ticket_order other_order
          break;
        elsif order_cost > other_order.its_cost
          if (other_order.its_cost == configus.platidoma.ticket_price and order_cost - configus.platidoma.ticket_price == configus.platidoma.afterparty_price) or (other_order.its_cost == configus.platidoma.afterparty_price and order_cost - configus.platidoma.afterparty_price == configus.platidoma.ticket_price)
            other_order.pay
            pay_part_if_ticket_order other_order
            order_cost -= other_order.its_cost
          end
        end
      end
    end
  end
end
