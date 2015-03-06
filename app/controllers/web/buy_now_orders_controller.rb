class Web::BuyNowOrdersController < Web::ApplicationController
  layout "web/promo"

  def new
    @form = BuyNowOrderType.new
  end

  def create
    # FIXME
    params[:order][:payment_system] = params[:payment_system]

    @form = BuyNowOrderType.new params[:order]

    if @form.valid?
      order = CreateOrder.call(
        tickets: @form.tickets,
        afterparty_tickets: @form.afterparty_tickets,
        coupon: current_coupon,
        params: {
          payment_system: @form.payment_system,
          customer_info: @form.to_hash
        }
      )

      pay_url = PaymentSystem.new(@form.payment_system).pay_url order
      redirect_to pay_url
    else
      flash_error message: @form.errors
      render :new
    end
  end

  def success
    @order = Order.find_by(number: params[:order_number])
  end
end
