class Web::Account::TicketOrdersController < Web::Account::ApplicationController
  skip_before_filter :authenticate_user!, only: [:new]

  def create
    @ticket_order = current_user.ticket_orders.build params[:ticket_order]
    gon.price = configus.platidoma.ticket_price
    if @ticket_order.save
      redirect_to build_payment_curl @ticket_order
    else
      flash_error
      render :new
    end
  end

end
