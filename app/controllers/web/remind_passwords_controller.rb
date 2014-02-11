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
        return redirect_to welcome_index_path
      end
    end

    return redirect_to new_remind_password_path
  rescue Net::SMTPAuthenticationError, SocketError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
    flash[:error] = t(".flash.controllers.web.remind_passwords.create.net_error") + e.message
    return redirect_to new_remind_password_path
  end

end
