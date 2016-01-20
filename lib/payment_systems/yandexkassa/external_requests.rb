module PaymentSystems::Yandexkassa::ExternalRequests
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

  def check_order(params)
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
      response_params[:message] = "Заказ с таким номером не существует"
    else
      response_params[:code] = SUCCESS_CODE
    end

    response.checkOrderResponse(response_params)
  end

  def payment_aviso(params)
    payment_aviso_params = fetch_params(params, PAYMENT_AVISO_PARAMS)
  end

  private

  def fetch_params(params, keys)
    params.permit(keys)
  end

  def response
    xml = Builder::XmlMarkup.new(:indent => true)
    xml.instruct!
    xml
  end

  def valid_sum?(params)
    received_sum = params["md5"]
    calculated_sum = params_digest(params)

    received_sum == calculated_sum
  end

  def valid_order_params?(params)
    order_number = params["orderNumber"]
    Order.exists?(number: order_number)
  end

  def params_digest(params)
    param_string = CHECK_SUM_PARAMS.reduce do |param_string, key|
      "#{param_string};#{params[key]}"
    end
    param_string.concat(";#{config.shared_secret}")
    calculated_digest = Digest::MD5.hexdigest(param_string).upcase
    calculated_digest
  end
end
