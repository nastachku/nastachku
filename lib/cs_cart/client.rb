module CsCart::Client
  def get_token(args)
    response = client_proxy.get_token(args).perform
    ActiveSupport::JSON.decode(response.body)["data"] if response.success?
  end

  def client_proxy
    @client_proxy ||= CsCart::ClientProxy.new
  end
end
