module PaymentSystems
  class Yandexkassa
    include ActiveSupport::Configurable

    CHECK_ORDER_PARAMS = [
      "requestDatetime", "action", "md5", "shopId", "shopArticleId",
      "invoiceId", "customerNumber", "orderCreatedDatetime",
      "orderSumAmount", "orderSumCurrencyPaycash",
      "orderSumBankPaycash", "shopSumAmount", "shopSumCurrencyPaycash",
      "shopSumBankPaycash", "paymentPayerCode", "paymentType"
    ]

    PAYMENT_AVISO_PARAMS = [
      "requestDatetime", "action", "md5", "shopId", "shopArticleId",
      "invoiceId", "customerNumber", "orderCreatedDatetime",
      "orderSumAmount", "orderSumCurrencyPaycash",
      "orderSumBankPaycash", "shopSumAmount", "shopSumCurrencyPaycash",
      "shopSumBankPaycash", "paymentDatetime", "paymentPayerCode",
      "paymentType"
    ]

    CHECK_SUM_PARAMS = [
      "action", "orderSumAmount", "orderSumCurrencyPaycash",
      "orderSumBankPaycash", "shopId", "invoiceId", "customerNumber",
      "shopPassword"
    ]

    SUCCESS_CODE = "0"
    AUTH_ERROR_CODE = "1"
    PARAMS_ERROR_CODE = "100"
    REQUEST_ERROR_CODE = "200"

    def self.check_order(params)
      check_order_params = fetch_params(params, CHECK_ORDER_PARAMS)

      current_time = Time.now.to_formatted_s(:iso8601)

      response_params = {
        performedDatetime: current_time,
        invoiceId: params["invoiceId"],
        shopId: params["shopId"],
        orderSumAmount: params["orderSumAmount"]
      }

      if !valid_sum?(params)
        response_params[:code] = AUTH_ERROR_CODE
      elsif !valid_order_params?(params)
        response_params[:code] = PARAMS_ERROR_CODE
      else
        response_params[:code] = SUCCESS_CODE
      end

      response.checkOrderResponse(response_params)
    end

    def self.payment_aviso(params)
      payment_aviso_params = fetch_params(params, PAYMENT_AVISO_PARAMS)
    end

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

    def self.fetch_params(params, keys)
      params.permit(keys)
    end

    def self.response
      xml = Builder::XmlMarkup.new(:indent => true)
      xml.instruct!
      xml
    end

    def self.valid_sum?(params)
      received_sum = params["md5"]
      calculated_sum = params_digest(params)

      received_sum == calculated_sum
    end

    def self.valid_order_params?(params)
      order_number = params["orderNumber"]
      order = Order.find_by(number: order_number)
    end

    def self.params_digest(params)
      param_string = CHECK_SUM_PARAMS.reduce do |param_string, key|
        "#{param_string};#{params[key]}"
      end
      param_string.concat(";#{config.shared_secret}")
      calculated_digest = Digest::MD5.hexdigest(param_string).upcase
      calculated_digest
    end

    def log(message)
      Rails.logger.tagged('PAYMENT SYSTEM', 'YANDEXKASSA') { Rails.logger.warn(message) }
    end
  end
end
