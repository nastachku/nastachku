
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
      flash_success message: flash_translate(:success)

      redirect_to root_path
    else
      flash_error message: flash_translate(:error)

      render action: "new"
    end
  end

end