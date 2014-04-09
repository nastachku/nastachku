class BroadcastMailerJobAfterCreate
  @queue = :broadcastmailer

  def self.perform(users)
    users.each_with_index do |user, i|
      id = user[:id] ? user[:id] : user["id"]
      unless id
        Rails.logger.error "ERROR ID IS NIL FOR #{user}"
        end
      UserMailer.sent_after_create_if_user_present(id).deliver_in((10 * (i + 1)).seconds)
      Rails.logger.info "BROADCASTING SEND EMAILS #{id}"
      sleep 1.second
    end
  end
end
