class Web::AccountsController < Web::ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = AccountEditType.find current_user.id
    build_order
  end

  def update
    @user = AccountEditType.find current_user.id
    build_order

    @user.changed_by = current_user
    if @user.update_attributes params[:user]
      flash_success
      redirect_to edit_account_path
    else
      render :edit
    end
  end

  def build_order
    @order = Order.new
    @order.tickets.build(price: Pricelist.ticket_price) unless current_user.ticket
    @order.afterparty_tickets.build(price: Pricelist.afterparty_ticket_price) unless current_user.afterparty_ticket

    @order.coupon = current_coupon
    @order.campaign = Campaign.suitable_for(@order.tickets.length, @order.afterparty_tickets.length, Time.current)
    @order.recalculate_cost

    @ticket = @order.tickets.first
    @afterparty_ticket = @order.afterparty_tickets.first
  end

end
