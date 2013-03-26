class Web::Account::ShirtOrdersController < Web::Account::ApplicationController

  def new
    @shirt_order = ShirtOrder.new
    gon.price = configus.platidoma.shirt_price
  end

  def create
    @shirt_order = current_user.shirt_orders.build params[:shirt_order]

    gon.price = configus.platidoma.shirt_price

    if @shirt_order.save
      redirect_to build_payment_curl(@shirt_order)
    else
      flash_error
      render :new
    end

  end

end
