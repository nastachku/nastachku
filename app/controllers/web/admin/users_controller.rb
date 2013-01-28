class Web::Admin::UsersController < Web::Admin::ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = UserEditType.create params[:user]
    if @user.save
      flash_success
      redirect_to admin_user_path(@user)
    else
      flash_error
      render "new"
    end
  end

  def show
    @user = User.find params[:id]
  end

  def index
    @users = User.web
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = UserEditType.find params[:id]
    if @user.update_attributes params[:user]
      flash_success
      redirect_to admin_user_path(@user)
    else
      flash_error
      render "new"
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.delete
    redirect_to admin_users_path
  end
end
