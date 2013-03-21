class Web::Account::AfterpartyOrdersController < Web::Account::ApplicationController

  def new
    @afterparty_order = AfterpartyOrder.new
    gon.price = configus.platidoma.afterparty_price
  end

  def create
    @afterparty_order = AfterpartyOrder.new params[:afterparty_order]
    @afterparty_order.user = current_user

    gon.price = configus.platidoma.afterparty_price

    if @afterparty_order.save
      redirect_to build_payment_curl(@afterparty_order)
    else
      flash_error
      render :new
    end

  end

end
