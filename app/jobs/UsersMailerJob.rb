class UsersMailerJob
  @queue = :usermailer

  def self.perform(mail_params_id)
    users = User.where(show_as_participant: false)
    users.each_with_index do |user, i|
      token = user.create_user_welcome_token
      UserMailer.conference_is_open(user.id, token.id, mail_params_id).deliver_in((10 * (i + 1)).seconds)
      sleep 1.second
    end
  end
end
