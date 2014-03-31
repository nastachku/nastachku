#FIXME перенести функциональность в гем
module CsCartHelper

  def auth_user_url(token)
    auth_user token
  end

  def get_token(args)
    response = client_proxy.get_token(args).perform
    binding.pry
    ActiveSupport::JSON.decode(response.body).values.symbolize_keys[:data] if response.success?
  end

  def get_auth_token(user)
    args = {
      first_name: user.first_name,
      last_name: user.last_name,
      id: user.id,
      email: user.email,
      key: Digest::MD5.hexdigest("#{user.first_name}|#{user.last_name}|#{user.id}")
    }
    token = get_token args
  end


  def auth_user(args)
    response = @client_proxy.auth_user args
  end

  def client_proxy
    @client_proxy ||= ClientProxy.new
  end

  class ClientProxy < Weary::Client
    post :get_token, "https://devel.cs-cart.ru/index.php?dispatch=auth.get_stachka_token" do |resource|
      resource.required :first_name, :last_name, :id, :email, :key
    end

    post :auth_user, "https://devel.cs-cart.ru/index.php?dispatch=auth.login_stachka" do |resource|
      resource.required :token
    end
  end

end
