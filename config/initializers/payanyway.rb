PaymentSystems::Payanyway.configure do |config|
  config.host = configus.payanyway.host
  config.payment_url = URI.join config.host, '/assistant.htm'
  config.id = Rails.application.secrets.payanyway_id
  config.integrity_check_code = Rails.application.secrets.payanyway_integrity_check_code
  config.currency = 'RUB'
  config.test_mode = configus.payanyway.test_mode
end
