class Web::Account::TicketOrdersController < Web::Account::ApplicationController
  skip_before_filter :authenticate_user!, only: [:new]

  def create
    @ticket_order = TicketOrder.new params[:ticket_order]
    if @ticket_order.save
      flash_success
      redirect_to edit_account_path
    else
      flash_error
      redirect_to edit_account_path
    end
  end
end
