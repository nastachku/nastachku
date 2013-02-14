class Web::Admin::UsersController < Web::Admin::ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = ::Admin::UserEditType.new(params[:user])
    if @user.save
      flash_success
      redirect_to admin_users_path
    else
      flash_error
      render "new"
    end
  end

  def index
    @users = User.web
  end

  def show
    @user = ::Admin::UserEditType.find params[:id]
  end

  def edit
    @user = ::Admin::UserEditType.find params[:id]
  end

  def update
    @user = ::Admin::UserEditType.find(params[:id])
    if @user.update_attributes params[:user]     
      flash_success
      redirect_to admin_users_path
    else
      flash_error
      render "edit"
    end
  end

   def destroy
     @user = User.find params[:id]
     @user.delete
     redirect_to admin_users_path
   end

end