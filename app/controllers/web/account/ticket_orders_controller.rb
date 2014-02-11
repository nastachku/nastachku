class Web::Account::TicketOrdersController < Web::Account::ApplicationController
  skip_before_filter :authenticate_user!, only: [:new]

<<<<<<< HEAD
  def create
    @ticket_order = current_user.ticket_orders.build params[:ticket_order]
    gon.price = configus.platidoma.ticket_price
    if @ticket_order.save
=======
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
>>>>>>> 940c36cc6eab2279d083dac39d5d976c4827fac5
      redirect_to build_payment_curl @ticket_order
    else
      flash_error
      render :new
    end
  end
<<<<<<< HEAD

=======
>>>>>>> 940c36cc6eab2279d083dac39d5d976c4827fac5
end
