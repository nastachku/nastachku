
class Web::Account::SessionsController < Web::Account::ApplicationController

  def new
    @user = UserEditType.new
  end

  def create
    user = UserEditType.find_by_email(params[:user][:email])

    if user.try(:authenticate, params[:user][:password])
      flash_success message: flash_translate(:success)

      sign_in(user)
      redirect_to root_path
    else
      flash_error message: flash_translate(:error)

      render action: 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
