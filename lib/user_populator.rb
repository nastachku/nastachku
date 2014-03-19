module UserPopulator

  def self.via_facebook(user, session_auth_hash)
    user.email = session_auth_hash[:info][:email]
    user.first_name = session_auth_hash[:info][:first_name]
    user.last_name = session_auth_hash[:info][:last_name]
    user.facebook = session_auth_hash[:info][:urls][:Facebook]
    user
  end

end
