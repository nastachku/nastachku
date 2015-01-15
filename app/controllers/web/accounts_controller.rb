class Web::AccountsController < Web::ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = AccountEditType.find current_user.id
    @ticket_order = TicketOrder.new
    @shirt_order = ShirtOrder.new
    if params[:discount_code]
      @discount = Discount.find_by_code params[:discount_code]
      @price_with_discount = @discount.cost
    end
    gon.promo_code_action = accept_account_promo_code_path(@user.promo_code)
  end

  def update
    @user = AccountEditType.find current_user.id
    @user.changed_by = current_user
    if @user.update_attributes params[:user]
      flash_success
      redirect_to edit_account_path
    else
      flash[:error] = @user.errors.full_messages
      redirect_to action: "edit"
    end
  end

end
