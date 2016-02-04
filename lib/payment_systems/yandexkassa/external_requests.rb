module PaymentSystems::Yandexkassa::ExternalRequests

  CHECK_SUM_PARAMS = [
    "action", "orderSumAmount", "orderSumCurrencyPaycash",
    "orderSumBankPaycash", "shopId", "invoiceId", "customerNumber"
  ]

  SUCCESS_CODE = "0"
  AUTH_ERROR_CODE = "1"
  PARAMS_ERROR_CODE = "100"
  REQUEST_ERROR_CODE = "200"

  def check_order(params)
    current_time = Time.now.to_formatted_s(:iso8601)
    response_params = {
      performedDatetime: current_time,
      invoiceId: params["invoiceId"],
      shopId: params["shopId"],
      orderSumAmount: params["orderSumAmount"]
    }

    if !valid_digest?(params)
      response_params[:code] = AUTH_ERROR_CODE
      log("Check order ##{params["orderNumber"]}: auth error")
    elsif !valid_order_params?(params)
      response_params[:code] = PARAMS_ERROR_CODE
      response_params[:message] = "Заказ с таким номером не существует"
      log("Check order ##{params["orderNumber"]}: not found error")
    else
      response_params[:code] = SUCCESS_CODE
      log("Check order ##{params["orderNumber"]}: succeed")
    end

    response.checkOrderResponse(response_params)
  end

  def payment_aviso(params)
    current_time = Time.now.to_formatted_s(:iso8601)
    response_params = {
      performedDatetime: current_time,
      invoiceId: params["invoiceId"],
      shopId: params["shopId"],
      orderSumAmount: params["orderSumAmount"]
    }

    if !valid_digest?(params)
      response_params[:code] = AUTH_ERROR_CODE
      log("Payment aviso ##{params["orderNumber"]}: auth error")
    else
      response_params[:code] = SUCCESS_CODE
      order = Order.find_by(number: params["orderNumber"])

      if order.buy_now?
        ProcessPaidOrder.call order, :buy_now
      else
        ProcessPaidOrder.call order, :regular
      end

      log("Payment aviso ##{params["orderNumber"]}: succeed")
    end

    response.paymentAvisoResponse(response_params)
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

  def valid_digest?(params)
    received_sum = params["md5"]
    calculated_sum = params_digest(params)

    received_sum == calculated_sum
  end

  def valid_order_params?(params)
    order_number = params["orderNumber"]
    Order.exists?(number: order_number)
  end

  def params_digest(params)
    param_string = ""

    CHECK_SUM_PARAMS.each do |key|
      param_string.concat("#{params[key]};")
    end
    param_string.concat(config.shared_secret.to_s)

    calculated_digest = Digest::MD5.hexdigest(param_string).upcase
    calculated_digest
  end

  def log(message)
    Rails.logger.tagged('PAYMENT SYSTEM', 'YANDEXKASSA') { Rails.logger.warn(message) }
  end
end
