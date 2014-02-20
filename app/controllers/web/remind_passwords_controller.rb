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
        token = user.create_remind_password_token
        UserMailer.delay.remind_password(user, token)
        flash_success
        return redirect_to welcome_index_path
      else
        flash[:error] = t :inactive, scope: [:activemodel, :errors, :models, :user_password_remind_type]
      end
    else
      flash[:error] = @type.errors.messages.values.flatten.first
    end
    
    return redirect_to new_remind_password_path
  rescue Net::SMTPAuthenticationError, SocketError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError, Errno::ECONNREFUSED => e
    flash[:error] = t(".flash.controllers.web.remind_passwords.create.net_error") + e.message
    return redirect_to new_remind_password_path
  end

end
