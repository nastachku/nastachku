class UserMailer < AsyncMailer
  default_url_options[:host] = configus.mailer.default_host
  default from: configus.mailer.default_from

  def confirm_registration(user_id, token_id)
    @user = User.find_by_id user_id
    @token = User::AuthToken.find_by_id token_id
    mail :to => @user.email
  end

  def sent_after_create(user_id)
    @user = User.find_by_id user_id
    mail :to => @user.email
  end

  def remind_password(user_id, token_id)
    @user = User.find_by_id user_id
    @token = User::AuthToken.find_by_id token_id
    mail :to => @user.email
  end

  def payment_successful(user_id, token_id)
    @user = User.find_by_id user_id
    @token = User::AuthToken.find_by_id token_id
    mail :to => @user.email
  end

  def send_mail(user_id, mail_params_id)
    params = MailParams.find_by_id mail_params_id
    @user = UserDecorator.decorate(User.find_by_id user_id)
    @mail_content = params.mail_content
    @subject = params.subject
    mail :to => @user.email, subject: @subject
  end

  def conference_is_open(user_id, token_id, mail_params_id)
    params = MailParams.find_by_id mail_params_id
    @user = UserDecorator.decorate(User.find_by_id user_id)
    @token = User::AuthToken.find_by_id token_id
    @subject = params.subject
    @begin_of_greetings = params.begin_of_greetings
    @end_of_greetings = params.end_of_greetings
    @mail_content = params.mail_content
    @before_link = params.before_link
    @after_link = params.after_link
    @goodbye = params.goodbye
    mail :to => @user.email, subject: @subject
  end
end
