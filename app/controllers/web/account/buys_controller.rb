class Web::Account::BuysController < Web::Account::ApplicationController
  def pay
    @order = Order.new(items_count: 1, user_id: params[:shirt_order][:user_id])
    @order.cost = 0
    if params[:ticket_order]
      @ticket_order = TicketOrder.new(items_count: 1, user_id: params[:shirt_order][:user_id])
      @ticket_order.save
      @order.cost += @ticket_order.its_cost
    end
    @shirt_order = ShirtOrder.new params[:shirt_order]
    if @shirt_order.save
      @order.cost += @shirt_order.its_cost
    end
    if @order.save
      redirect_to build_payment_curl @order
    else
      redirect_to edit_account_path
    end
  end
end
