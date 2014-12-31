class Web::Account::PasswordsController < Web::ApplicationController

  def edit
    @user = UserPasswordConfirmationType.new
    token = User::AuthToken.find_by_authentication_token(params[:auth_token])
    unless token
      flash[:error] = t :error, scope: [:flash, :controllers, :web, :account, :passwords, :edit]
      return redirect_to welcome_index_path
    end
  end

  def update
    @token = User::AuthToken.find_by_authentication_token!(params[:auth_token])
    @user = UserPasswordConfirmationType.find @token.user.id
    @user.changed_by = current_user
    if @token && !@token.expired?
      if @user.update_attributes(params[:user])
        sign_in @user
        flash_success
        return redirect_to auth_cs_cart_user_url get_auth_token @user
      end
    end

    flash_error
    render :edit
  end

end
