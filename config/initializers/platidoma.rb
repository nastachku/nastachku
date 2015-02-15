PaymentSystems::Platidoma.configure do |config|
  config.shop_id = Rails.application.secrets.platidoma_shop_id
  config.login = Rails.application.secrets.platidoma_login
  config.gate_password = Rails.application.secrets.platidoma_gate_password
end
