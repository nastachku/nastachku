class Web::RemindPasswordsController < Web::ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.active?
      token = @user.build_auth_token
      token.save!
      UserMailer.remind_password(@user, token).deliver
      flash_success
      redirect_to root_path
    else
      @user = User.new params[:user]
      flash_error
      render :new
    end
  end

end