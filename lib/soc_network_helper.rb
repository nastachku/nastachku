module SocNetworkHelper
  def auth_hash
    request.env['omniauth.auth']
  end

  def build_authorization(auth_hash)
    Authorization.new(provider: auth_hash[:provider], uid: auth_hash[:uid])
  end
end
