class Web::Admin::UsersController < Web::Admin::ApplicationController
  
  def index
    @users = User.web
  end

  def destroy
    @user = User.find params[:id]
    @user.delete
    redirect_to admin_users_path
  end

end
