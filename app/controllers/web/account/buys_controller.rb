class Web::Account::BuysController < Web::Account::ApplicationController
  def pay
    order = CreateOrder.call(
      user: current_user,
      with_ticket: !!params[:ticket],
      with_afterparty_ticket: !!params[:afterparty_ticket],
      params: {
        payment_system: params[:payment_system]
      }
    )

    pay_url = PaymentSystem.new(params[:payment_system]).pay_url order
    redirect_to pay_url
  end

  def ticket
    @order = current_user.orders.build
    @order.items_count = 0
    @order.cost = 0
    #FIXME вынести в метод, через current_user.send(:ticket_orders) или чтото подобное
    @ticket_order = current_user.ticket_orders.build(items_count: 1)
    if @ticket_order.save
      @order.cost += @ticket_order.its_cost
      @order.items_count += @ticket_order.items_count
    else
      flash_error
      redirect_to root_path
    end
    if @order.save
      redirect_to build_payment_curl @order
    else
      redirect_to root_path
    end
  end

  def afterparty
    @order = current_user.orders.build
    @order.items_count = 0
    @order.cost = 0
    #FIXME вынести в метод, через current_user.send(:ticket_orders) или чтото подобное
    @afterparty_order = current_user.afterparty_orders.build(items_count: 1)
    if @afterparty_order.save
      @order.cost += @afterparty_order.its_cost
      @order.items_count += @afterparty_order.items_count
    else
      flash_error
      redirect_to root_path
    end
    if @order.save
      redirect_to build_payment_curl @order
    else
      redirect_to root_path
    end
  end
end
