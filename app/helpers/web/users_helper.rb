module Web::UsersHelper
  def users_cache_key
    ( proc {
        user = User.activated.attended.alphabetically.order('updated_at DESC').limit(1).first
        {:tag => "#{user.updated_at.to_i if user}_#{params.except(:_).to_s}_#{current_user.id if current_user}"}
    } ).call

    def attended_users
      User.activated.attended.count
    end

    def shown_as_participants
      Russian.p(User.activated.attended.shown_as_participants.count, t('.one_participant'), t('.two_participant'), t('.many_participant'))
    end
  end
end
