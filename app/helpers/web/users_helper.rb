module Web::UsersHelper
  def users_cache_key
    ( proc {
        user = User.activated.attended.alphabetically.order('updated_at DESC').limit(1).first
        curr_user_id = current_user ? current_user.id : "none"
        {:tag => "#{user.updated_at.to_i if user}_#{params.except(:_).to_s}_#{curr_user_id}"}
    } ).call
  end
end
