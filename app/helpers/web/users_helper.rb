module Web::UsersHelper
  include CsCartHelper
  def users_cache_key
    ( proc {
        user = User.activated.participants.alphabetically.order('updated_at DESC').first
        curr_user_id = current_user ? "1" : "0"
        {:tag => "#{user.updated_at.to_i if user}_#{params.except(:_).to_s}_#{curr_user_id}"}
      } ).call
  end

  def attended_users
    User.activated.participants.count
  end

  def shown_as_participants
    Russian.p(User.activated.participants.count, t('.one_participant'), t('.two_participant'), t('.many_participant'))
  end
end
