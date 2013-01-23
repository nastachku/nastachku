
class Web::UsersController < Web::ApplicationController

  def index
    @users = User.shown_as_participants
  end

  def new
    @user = User.new
  end

  def create
    @user = UserEditType.new(params[:user])

    if @user.save
      flash_success

      redirect_to root_path
    else
      flash_error

      render action: "new"
    end
  end

end