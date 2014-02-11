class Web::Account::PasswordsController < Web::ApplicationController

  def edit
    @user = UserPasswordConfirmationType.new
  end

  def update
    @token = User::AuthToken.find_by_authentication_token!(params[:auth_token])
    @user = UserPasswordConfirmationType.find @token.user
    @user.changed_by = current_user
    if @token && !@token.expired?
      if @user.update_attributes(params[:user])
        sign_in @user
        flash_success
        return redirect_to welcome_index_path
      end
    end

    flash_error
    render :edit
  end

end
