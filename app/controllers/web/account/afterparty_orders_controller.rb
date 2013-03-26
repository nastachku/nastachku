class Web::Account::AfterpartyOrdersController < Web::Account::ApplicationController

  def new
    @afterparty_order = AfterpartyOrder.new
    gon.price = configus.platidoma.afterparty_price
    @count_paid_afterparty = AfterpartyOrder.paid.count + User.as_lectors.count
  end

  def create
    @afterparty_order = current_user.afterparty_orders.build params[:afterparty_order]

    gon.price = configus.platidoma.afterparty_price

    if @afterparty_order.save
      redirect_to build_payment_curl(@afterparty_order)
    else
      flash_error
      render :new
    end

  end

end
