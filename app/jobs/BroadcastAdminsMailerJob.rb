class BroadcastAdminsMailerJob
  @queue = :broadcastadminsmailer

  def self.perform(mail_params_id)
    users = User.where(admin: true)
    users.each_with_index do |user, i|
      UserMailer.send_mail(user.id, mail_params_id).deliver_in((10 * (i + 1)).seconds)
      Rails.logger.info "BROADCASTING SEND EMAILS #{user.id}"
      sleep 1.second
    end
  end
end
