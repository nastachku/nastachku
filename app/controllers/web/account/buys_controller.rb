class Web::Account::BuysController < Web::Account::ApplicationController
  def pay
    @order_pay = OrderPayType.new
    if params[:ticket_order]
      @ticket_order = TicketOrder.new(items_count: 1, user_id: params[:shirt_order][:user_id])
      @ticket_order.save
    end
    @order_pay.ticket_order = @ticket_order
    @shirt_order = ShirtOrder.new params[:shirt_order]
    if @shirt_order.save
      @order_pay.shirt_order = @shirt_order
    end
    redirect_to build_payment_curl @order_pay
  end
end
