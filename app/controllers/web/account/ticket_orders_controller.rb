class Web::Account::TicketOrdersController < Web::Account::ApplicationController
  def create
    @ticket_order = TicketOrder.new params[:ticket_order]
    binding.pry
    if @ticket_order.save
      flash_success
      redirect_to edit_account_path
    else
      flash_error
      redirect_to edit_account_path
    end
  end
end
