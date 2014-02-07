class Web::Account::TicketOrdersController < Web::Account::ApplicationController
  skip_before_filter :authenticate_user!, only: [:new]

  def new
    @ticket_order = TicketOrder.new
  end

  def create
    @ticket_order = current_user.ticket_orders.build params[:ticket_order]
    if @ticket_order.day.full?
      gon.price = configus.platidoma.full_ticket_price
    else
      gon.price = configus.platidoma.ticket_price
    end
    if @ticket_order.save
      @ticket_order.user.pay_part
      redirect_to build_payment_curl @ticket_order
    else
      flash_error
      render :new
    end
  end
end
