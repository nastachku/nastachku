class Web::RemindPasswordsController < Web::ApplicationController
  def new
    @type = UserPasswordRemindType.new
  end

  def create
    @type = UserPasswordRemindType.new params[:user_password_remind_type]
    if @type.valid?
      user = @type.user
      user.changed_by = current_user
      if user && user.active?
        token = user.create_auth_token
        UserMailer.remind_password(user, token).deliver
        flash_success
        return redirect_to root_path
      end
    end

    render :new
  end

end