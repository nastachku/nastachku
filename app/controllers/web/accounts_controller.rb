class Web::AccountsController < Web::ApplicationController

  before_filter :authenticate_user!

  def edit
    @user = AccountEditType.find current_user
    @ticket_order = TicketOrder.new
    @shirt_order = ShirtOrder.new
  end

  def update
    @user = AccountEditType.find current_user
    @user.changed_by = current_user
    if @user.update_attributes params[:user]
      flash_success
      redirect_to edit_account_path
    else
      flash_error
      render action: "edit"
    end
  end

end
