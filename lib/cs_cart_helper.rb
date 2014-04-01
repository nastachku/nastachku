module CsCartHelper

  def auth_cs_cart_user_url(token)
    "https://devel.cs-cart.ru/index.php?dispatch=auth.login_stachka&token=#{token}"
  end

  def get_token(args)
    response = client_proxy.get_token(args).perform
    ActiveSupport::JSON.decode(response.body)["data"] if response.success?
  end

  def get_auth_token(user)
    args = {
      first_name: user.first_name,
      last_name: user.last_name,
      stachka_id: user.id.to_s,
      email: user.email,
      key: Digest::MD5.hexdigest("#{user.first_name}|#{user.last_name}|#{user.id}|#{user.email}|#{configus.cs_cart.secret_key}")
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
      resource.required :first_name, :last_name, :stachka_id, :email, :key
    end
  end

end
