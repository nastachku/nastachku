class Web::Account::OrderOptionsController < Web::Account::ApplicationController
  skip_before_filter :authenticate_user!

  def create
    @order_option = OrderOption.new params[:order_option]
    if @order_option.save
      flash_success
      redirect_to edit_account_path
    else
      flash_error
      redirect_to edit_account_path
    end
  end
end
