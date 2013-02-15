class Web::AccountsController < Web::ApplicationController

  before_filter :authenticate_user!

  def edit
    @user = current_user.becomes(AccountEditType)    
  end

  def update
    @user = current_user.becomes(AccountEditType)

    if @user.update_attributes params[:user]
      flash_success
      redirect_to root_path
    else
      flash_error
      render action: "edit"
    end
  end

end
