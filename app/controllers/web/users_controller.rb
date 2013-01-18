
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
      redirect_to root_path, notice: t('.created')
    else
      render action: "new"
    end
  end

end