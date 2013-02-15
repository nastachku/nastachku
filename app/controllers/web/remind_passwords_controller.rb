class Web::RemindPasswordsController < Web::ApplicationController
  def new
    @type = UserPasswordRemindType.new
  end

  def create
    @type = UserPasswordRemindType.new params[:user_password_remind_type]
    if @type.valid?
      user = @type.user
      if user && user.active?
        user.remind_password
        flash_success
        return redirect_to root_path
      end
    end

    render :new
  end

end