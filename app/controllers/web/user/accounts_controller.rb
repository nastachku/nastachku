
class Web::User::AccountsController < Web::User::ApplicationController

  before_filter :authenticate_user!

  def edit
    @user = UserEditType.find params[:id]
  end

  def update
    @user = UserEditType.find params[:id]

    if @user.update_attributes params[:user]
      flash_success message: flash_translate(:success)

      redirect_to root_path
    else
      render action: "new"
    end
  end

end