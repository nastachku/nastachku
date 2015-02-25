class Web::SessionsController < Web::ApplicationController
  def new
    if params[:auth_token]
      token = User::AuthToken.find_by_authentication_token params[:auth_token]
      if token
        user = token.user
        @email = user.email
      end
    end

    @type = UserSignInType.new
  end

  def create
    @type = UserSignInType.new params[:user_sign_in_type]
    if @type.valid?
      user = @type.user
      flash_success
      sign_in user

      redirect_path = if params[:from] == registrator_root_url
        registrator_root_url
      elsif configus.cs_cart.enable_auth
        auth_cs_cart_user_url get_auth_token user
      else
        edit_account_path(anchor: :orders)
      end

      redirect_to redirect_path
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to welcome_index_path
  end

end
