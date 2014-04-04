class Preview < MailView
  def broadcast
    params = MailParams.last
    user = UserDecorator.decorate(User.first)
    UserMailer.send_mail(user.id, params.id)
  end
end
