class Web::BuyNowOrdersController < Web::ApplicationController
  layout "buy_now"

  def new
    @order = BuyNowOrderType.new
  end

  def create
    @order = BuyNowOrderType.new params[:order]
    if @order.valid?
      order = CreateOrder.call(tickets: @order.tickets,
                               afterparty_tickets: @order.afterparty_tickets,
                               params: {
                                 payment_system: @order.payment_system
                               })

      pay_url = PaymentSystem.new(params[:payment_system]).pay_url order
      redirect_to pay_url
    else
      flash_notice
      redirect_to buy_now_path
    end
  end

  def success
    @order = Order.find_by(number: params[:order_number])
  end
end
