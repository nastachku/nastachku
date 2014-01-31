class Web::Admin::MailersController < Web::Admin::ApplicationController
  def index
    @user = UserDecorator.decorate(User.first)
    @token = @user.create_auth_token
  end

  def deliver
    users = UserDecorator.decorate_collection(User.all)
    users.each do |user|
      token = SecureHelper.generate_token
      expired_at = Time.current + 1.year
      user.auth_tokens.create! :authentication_token => token, :expired_at => expired_at
      UserMailer.conference_is_open(user, token, params).deliver
    end
    flash_success
    redirect_to admin_mailers_path
  end
end
