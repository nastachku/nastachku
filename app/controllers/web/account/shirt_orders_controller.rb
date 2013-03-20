class Web::Account::ShirtOrdersController < Web::ApplicationController

  def new
    @shirt_order = ShirtOrder.new
    gon.price = configus.platidoma.shirt_price
  end

  def create
    @shirt_order = ShirtOrder.new params[:shirt_order]
    @shirt_order.user = current_user
    
    gon.price = configus.platidoma.shirt_price

    gon.price = configus.platidoma.shirt_price

    if @shirt_order.save
      redirect_to build_payment_curl(@shirt_order)
    else
      flash_error
      render :new
    end

  end

end
