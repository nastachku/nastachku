module SocNetworkHelper

  def auth_hash
    request.env['omniauth.auth']
  end

  def session_auth_hash
    session[:auth_hash]
  end

  def build_authorization(auth_hash)
    Authorization.new(provider: auth_hash[:provider], uid: auth_hash[:uid])
  end

  def save_auth_hash_to_session
    session[:auth_hash] = auth_hash
  end

  def clear_session_auth_hash
    session[:auth_hash] = nil
  end

  def registration_by_soc_network?
    session[:auth_hash] ? true : false
  end 

  def twitter_provider?
    auth_hash[:provider] == "twitter"
  end

  def session_twitter_name
    session[:auth_hash][:info][:nickname]
  end

  def clear_twitter_link(user)
    user.twitter_name = ""
  end

end