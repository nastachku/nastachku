class Web::BuyNowOrdersController < Web::ApplicationController
  layout "buy_now"

  def new
    @order = BuyNowOrderType.new
  end

  def create
    @form = BuyNowOrderType.new params[:order]
    if @form.valid?
      order = CreateOrder.call(
        tickets: @form.tickets,
        afterparty_tickets: @form.afterparty_tickets,
        params: {
          payment_system: @form.payment_system,
          customer_info: @form.to_hash
        }
      )

      pay_url = PaymentSystem.new(@form.payment_system).pay_url order
      redirect_to pay_url
    else
      flash_notice
      redirect_to buy_now_path
    end
  end

  def success
    UserMailer.send_ticket_codes(@order.id).deliver
    @order = Order.find_by(number: params[:order_number])
  end
end
