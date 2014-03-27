module Web::UsersHelper
  def users_cache_key
    ( proc {
        user = User.activated.attended.alphabetically.order('updated_at DESC').limit(1).first
        {:tag => "#{user.updated_at.to_i if user}_#{params.except(:_).to_s}_#{current_user.id if current_user}"}
    } ).call
  end
end
