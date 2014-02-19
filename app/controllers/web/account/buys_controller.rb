class Web::Account::BuysController < ApplicationController
  def create
    if params[:ticket_order]
      @ticket_order = TicketOrder.new(items_count: 1, user_id: params[:shirt_order][:user_id])
      @ticket_order.save
    end
    @shirt_order = ShirtOrder.new params[:shirt_order]
    if @shirt_order.save
      flash_success
      redirect_to edit_account_path
    else
      redirect_to edit_account_path
    end
  end
end
