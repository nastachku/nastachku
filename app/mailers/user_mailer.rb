class UserMailer < AsyncMailer 
  default_url_options[:host] = configus.mailer.default_host
  default from: configus.mailer.default_from

  def confirm_registration(user, token)
    @user = user
    @token = token
    mail :to => @user.email
  end

  def remind_password(user, token)
    @user = user
    @token = token
    mail :to => @user.email
  end

  def payment_successful(user, token)
    @user = user
    @token = token
    mail :to => @user.email
  end

  def conference_is_open(user, token, params)
    user = user["user"].symbolize_keys!
    token = token.symbolize_keys!
    params = params.symbolize_keys!
    @full_name = "#{user[:last_name]} #{user[:first_name]}"
    @token = token[:authentication_token]
    @subject = params[:subject]
    @begin_of_greetings = params[:begin_of_greetings]
    @end_of_greetings = params[:end_of_greetings]
    @mail_content = params[:mail_content]
    @before_link = params[:before_link]
    @after_link = params[:after_link]
    @goodbye = params[:goodbye]
    mail :to => user[:email], subject: @subject
  end
end
