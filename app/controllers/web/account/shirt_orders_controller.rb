class Web::Account::ShirtOrdersController < Web::Account::ApplicationController
  def create
    @shirt_order = ShirtOrder.new params[:shirt_order]
    if @shirt_order.save
      flash_success
      redirect_to edit_account_path
    else
      flash_error
      render :new
    end

  end

end
