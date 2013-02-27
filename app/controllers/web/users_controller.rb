class Web::UsersController < Web::ApplicationController

  def index
    @search = User.ransack(params[:q])
    if params[:q]
      @users = @search.result.activated.shown_as_participants
    else
      @users = @search.result.activated.shown_as_participants.alphabetically
    end

  end

  def new
    @user = UserRegistrationType.new
  end

  def activate
    token = User::AuthToken.find_by_authentication_token!(params[:auth_token])
    user = token.user
    if token && user
      user.activate!
      sign_in user
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