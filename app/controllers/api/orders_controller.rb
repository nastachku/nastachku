class Api::OrdersController < Api::ApplicationController
  def prices
    @order = Order.new

    tickets_count = params[:tickets_count].to_i
    if tickets_count
      tickets_count.times do
        @order.tickets.build(price: Pricelist.ticket_price)
      end
    end

    afterparty_tickets_count = params[:afterparty_tickets_count].to_i
    if afterparty_tickets_count
      afterparty_tickets_count.times do
        @order.afterparty_tickets.build(price: Pricelist.afterparty_ticket_price)
      end
    end

    @order.coupon = current_coupon
    @order.campaign = Campaign.suitable_for(@order.tickets.length, @order.afterparty_tickets.length, Time.current)
    @order.recalculate_cost
  end
end
