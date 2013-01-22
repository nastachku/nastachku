
class Web::Account::AccountsController < Web::Account::ApplicationController

  before_filter :authenticate_user!

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

      render action: "new"
    end
  end

end