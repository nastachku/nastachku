PaymentSystems::Yandexkassa.configure do |config|
  config.url = configus.yandexkassa.pay_url
  config.http_method = :post
  config.shopId = Rails.application.secrets.yandexkassa_shopId
  config.scid = Rails.application.secrets.yandexkassa_scid
  config.currency = 'RUB'
  config.shared_secret = Rails.application.secrets.yandexkassa_shared_secret
end
