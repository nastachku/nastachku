class Web::BuyNowsController < Web::ApplicationController
  layout "web/promo"

  def new
    @form = BuyNowOrderType.new

    @meta_tags = {
      title: "x",
      description: "y",
      keywords: "i"
    }

    build_order
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
          from: :buy_now,
          payment_system: @form.payment_system,
          customer_info: @form.to_hash
        }
      )

      pay_url = PaymentSystem.new(@form.payment_system).pay_url order
      redirect_to pay_url
    else
      build_order
      render :new
    end
  end

  def success
    @order = Order.find_by(number: params[:order_number])
  end

  private
    def build_order
      @order = Order.new
      params_hash = params[:order] || {}

      tickets_count = (params_hash[:tickets] || 1).to_i
      tickets_count.times do
        @order.tickets.build(price: Pricelist.ticket_price)
      end

      afterparty_tickets_count = (params_hash[:afterparty_tickets] || 1).to_i
      afterparty_tickets_count.times do
        @order.afterparty_tickets.build(price: Pricelist.afterparty_ticket_price)
      end

      @order.coupon = current_coupon
      @order.campaign = Campaign.suitable_for(@order.tickets.length, @order.afterparty_tickets.length, Time.current)
      @order.recalculate_cost
    end
end
