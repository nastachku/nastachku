class UserMailer < ActionMailer::Base
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
end