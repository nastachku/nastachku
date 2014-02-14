class Web::UsersController < Web::ApplicationController
  respond_to :html, :json

  def index
    @search = User.ransack(params)
    @users = @search.result.activated.attended.alphabetically

    respond_with(@users)
  end

  def new
    @user = UserRegistrationType.new

    if registration_by_soc_network?
      @user = UserPopulator.via_facebook(@user, session_auth_hash)
    end

  end

  def activate
    token = User::AuthToken.find_by_authentication_token(params[:auth_token])
    unless token
      flash[:error] = t :error, scope: [:flash, :controllers, :web, :users, :activate]
      return redirect_to welcome_index_path
    end
    user = token.user
    if token && user
      user.activate!
      sign_in user
      flash_success
    else
      flash_error
    end
    redirect_to welcome_index_path
  end

  def create
    @user = UserRegistrationType.new params[:user]
    if @user.save
      User::PromoCode.create({ code: generate_promo_code, user_id: @user.id })
      if registration_by_soc_network?
        @user.authorizations << build_authorization(session_auth_hash)
        @user.activate
        clear_session_auth_hash
        sign_in @user
        redirect_to welcome_index_path
      else
        token = @user.create_auth_token
        UserMailer.confirm_registration(@user, token).deliver
        flash_success
        redirect_to new_session_path
      end
    else
      flash_error
      render action: "new"
    end
  rescue Net::SMTPAuthenticationError, SocketError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError, Errno::ECONNREFUSED => e
    flash[:error] = t(".flash.controllers.web.users.create.net_error") + e.message
  end

  def attend
    @user = User.find params[:id]
    @user.attend
    redirect_to edit_account_path
  end
end
