
class Web::SessionsController < Web::ApplicationController

  def new
    @type = UserSignInType.new
  end

  def create
    @type = UserSignInType.new(params[:user_sign_in_type])

    if @type.valid?
      user = @type.user
      flash_success
      sign_in(user)
      if params[:from]
        redirect_to params[:from]
      else
        redirect_to root_path
      end
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
