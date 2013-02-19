
class Web::SessionsController < Web::ApplicationController

  def new
    #FIXME Frank change this type to UserSignInType
    @user = UserRegistrationType.new
  end

  def create
    #FIXME Frank change this type to UserSignInType
    user = UserRegistrationType.find_by_email(params[:user][:email])

    if user.try(:authenticate, params[:user][:password])
      flash_success

      sign_in(user)
      redirect_to root_path
    else
      flash_error

      render action: 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
