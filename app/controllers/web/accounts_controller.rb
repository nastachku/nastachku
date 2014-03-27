class Web::AccountsController < Web::ApplicationController

  before_filter :authenticate_user!
  after_filter(only: [:update]) { |c| expire_my_action("/web/users", "index") }

  def edit
    @user = AccountEditType.find current_user
    @ticket_order = TicketOrder.new
    @shirt_order = ShirtOrder.new
    gon.promo_code_action = accept_account_promo_code_path(@user.promo_code)
  end

  def update
    expire_page controller: "users", action: "index"
    @user = AccountEditType.find current_user
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
