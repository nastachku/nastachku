class Web::Account::AfterpartyOrdersController < Web::ApplicationController

  def new
    @afterparty_order = AfterpartyOrder.new
  end

  def create
    @afterparty_order = AfterpartyOrder.new params[:afterparty_order]
    @afterparty_order.user = current_user

    if @afterparty_order.save
      redirect_to build_payment_curl(@afterparty_order)
    else
      flash_error
      render :new
    end

  end

end
