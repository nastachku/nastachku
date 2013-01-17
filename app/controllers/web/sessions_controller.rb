
class Web::SessionsController < Web::ApplicationController

  def new
  end

  def create
    user = UserEditType.find_by_email(params[:user][:email])

    if user.try(:authenticate, params[:user][:password])
      sign_in(user)

      flash.now[:notice] = t('login.successful')
      redirect_to home_path
    else
      flash.now[:error] = t('login.failed')
      render action: :new
    end
  end

  def destroy
    sign_out
    redirect_to new_session_path
  end

end
