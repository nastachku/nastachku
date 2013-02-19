class Web::UsersController < Web::ApplicationController

  def index
    @users = User.activated.shown_as_participants.alphabetically
  end

  def new
    @user = UserRegistrationType.new
  end

  def activate
    token = User::AuthToken.find_by_authentication_token!(params[:auth_token])
    user = token.user
    if token && user
      user.activate!
      flash_success
    else
      flash_error
    end
    redirect_to root_path
  end

  def create
    @user = UserRegistrationType.new(params[:user])

    if @user.save
      token = @user.create_auth_token
      UserMailer.confirm_registration(@user, token).deliver
      #sign_in @user
      flash_success
      redirect_to new_session_path
    else
      flash_error
      render action: "new"
    end
  end

end