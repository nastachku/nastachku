class Web::AccountsController < Web::ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = AccountEditType.find current_user.id
    @ticket_order = TicketOrder.new
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
