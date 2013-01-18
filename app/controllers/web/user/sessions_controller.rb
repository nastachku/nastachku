
class Web::User::SessionsController < Web::User::ApplicationController

  def new
    @user = UserEditType.new
  end

  def create
    user = UserEditType.find_by_email(params[:user][:email])

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
    redirect_to new_user_session_path
  end

end
