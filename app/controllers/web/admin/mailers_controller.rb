class Web::Admin::MailersController < Web::Admin::ApplicationController
  def index
    @user = UserDecorator.decorate(User.first)
    @token = @user.create_user_welcome_token
    @users_size = User.where(attending_conference_state: :not_decided).size
  end

  def deliver
    begin
      attrs = [:subject, :begin_of_greetings, :end_of_greetings, :mail_content,
       :before_link, :after_link, :goodbye]
      mail_attrs = Hash[attrs.collect { |x| [x, params[x]] }]
      mail_params = MailParams.create mail_attrs
      Resque.enqueue UsersMailerJob, mail_params.id
      flash_success
      redirect_to admin_mailers_path
    rescue Net::SMTPAuthenticationError, SocketError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError, Errno::ECONNREFUSED => e
      flash[:error] = t(".flash.controllers.web.admin.mailers.deliver.error") + e.message
    end
  end
end
