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
    session[:auth_hash] = {}
    session[:auth_hash][:provider] = auth_hash[:provider]
    session[:auth_hash][:uid] = auth_hash[:uid]
    session[:auth_hash][:info] = {}
    session[:auth_hash][:info][:email] = auth_hash[:info][:email]
    session[:auth_hash][:info][:first_name] = auth_hash[:info][:first_name]
    session[:auth_hash][:info][:last_name] = auth_hash[:info][:last_name]
    session[:auth_hash][:info][:location] = auth_hash[:info][:location]
  end

  def clear_session_auth_hash
    session[:auth_hash] = nil
  end

  def registration_by_soc_network?
    session[:auth_hash] ? true : false
  end 

end