class Web::Account::BuysController < Web::Account::ApplicationController
  def pay
    @ticket_order = TicketOrder.new(items_count: 1, user_id: params[:shirt_order][:user_id])
    if @ticket_order.save
      redirect_to build_payment_curl @ticket_order
    else
      redirect_to edit_account_path
    end
  end
end
