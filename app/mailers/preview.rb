class Preview < MailView
  def broadcast
    params = MailParams.last
    @user = UserDecorator.decorate(User.first)
    @mail_content = params.mail_content
    @subject = params.subject
    UserMailer.broadcast(@user.id, params.id)
  end
end
