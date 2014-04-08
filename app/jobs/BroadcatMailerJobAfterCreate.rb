class BroadcastMailerJobAfterCreate
  @queue = :broadcastmailer

  def self.perform(users)
    users.each_with_index do |user, i|
      UserMailer.sent_after_create(user.id).deliver_in((10 * (i + 1)).seconds)
      Rails.logger.info "BROADCASTING SEND EMAILS #{user.id}"
      sleep 1.second
    end
  end
end
