class CsCart::ClientProxy < Weary::Client
  post :get_token, "https://devel.cs-cart.ru/index.php?dispatch=auth.get_stachka_token" do |resource|
    resource.required :first_name, :last_name, :stachka_id, :email, :key
  end
end
