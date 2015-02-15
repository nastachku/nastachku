class Web::Admin::MailersController < Web::Admin::ApplicationController
  def index
    @user = UserDecorator.decorate(User.first)
    @token = @user.create_user_welcome_token
    @attended_users_size = User.where(show_as_participant: false).size
    @users_size =  User.includes(:orders).where(orders: {payment_state: :paid, type: "AfterpartyOrder"}).count
    @admins_size = User.where(admin: true).count
  end

  def broadcast_to_not_attended
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

  def broadcast
    attrs = [:subject, :mail_content]
    mail_attrs = Hash[attrs.collect { |x| [x, params[x]] }]
    mail_params = MailParams.create mail_attrs
    Resque.enqueue BroadcastMailerJob, mail_params.id
    flash_success
    redirect_to admin_mailers_path
  end

  def broadcast_to_admins
    attrs = [:subject, :mail_content]
    mail_attrs = Hash[attrs.collect { |x| [x, params[x]] }]
    mail_params = MailParams.create mail_attrs
    Resque.enqueue BroadcastAdminsMailerJob, mail_params.id
    flash_success
    redirect_to admin_mailers_path
  end

  def preview
    attrs = [:subject, :mail_content]
    mail_attrs = Hash[attrs.collect { |x| [x, params[x]] }]
    mail_params = MailParams.create mail_attrs
    redirect_to "/mailer_preview/broadcast"
  end
end
