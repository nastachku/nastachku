class BroadcastMailerJob
  @queue = :broadcastmailer

  def self.perform(mail_params_id)
    users = User.all
    users.each_with_index do |user, i|
      UserMailer.broadcast(user.id, mail_params_id).deliver_in((10 * (i + 1)).seconds)
      logger.info "BROADCASTING SEND EMAILS #{user.id}"
      sleep 1.second
    end
  end
end
