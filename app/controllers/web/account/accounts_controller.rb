class Web::Account::AccountsController < Web::Account::ApplicationController

  def edit
    @user = UserEditType.find params[:id]
  end

  def update
    @user = UserEditType.find params[:id]

    if @user.update_attributes params[:user]
      flash_success
      redirect_to root_path
    else
      flash_error
      render action: "edit"
    end
  end

end