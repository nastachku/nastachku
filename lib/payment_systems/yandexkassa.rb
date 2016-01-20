module PaymentSystems
  class Yandexkassa
    include ActiveSupport::Configurable
    extend PaymentSystems::Yandexkassa::ExternalRequests

    def initialize
      @id = config.id
      @currency_code = config.currency
      @test_mode = config.test_mode
      @integrity_check_code = config.integrity_check_code
    end

    def form_params(order)
      {
        url: config.url,
        method: config.http_method,
        fields: {
          # Обязательные поля
          shopId: config.shopId,
          scid: config.scid,
          sum: order.cost,
          customerNumber: order.user_id,
          # Необязательные поля
          paymentType: config.paymentType,
          orderNumber: order.number,
        }
      }
    end

    def send_method
      :form_submit
    end

    private

    def log(message)
      Rails.logger.tagged('PAYMENT SYSTEM', 'YANDEXKASSA') { Rails.logger.warn(message) }
    end
  end
end
