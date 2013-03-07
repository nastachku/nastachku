class Web::UsersController < Web::ApplicationController

  def index
    @search = User.ransack(params)
    @users = @search.result.activated.shown_as_participants.alphabetically
  end

  def new
    @user = UserRegistrationType.new

    if registration_by_soc_network?
      @user = UserPopulator.via_facebook(@user, session_auth_hash)
    end

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
      
      if registration_by_soc_network?
        @user.authorizations << build_authorization(session_auth_hash)
        clear_session_auth_hash
      end

      token = @user.create_auth_token
      UserMailer.confirm_registration(@user, token).deliver
      flash_success
      redirect_to new_session_path
    else
      flash_error
      render action: "new"
    end
  end

end