class Web::Account::ShirtOrdersController < Web::ApplicationController

  def new
    @shirt_order = ShirtOrder.new
  end

  def create
    @shirt_order = ShirtOrder.new params[:shirt_order]
    @shirt_order.user = current_user

    if @shirt_order.save
      redirect_to build_payment_curl(@shirt_order)
    else
      flash_error
      render :new
    end

  end

end
