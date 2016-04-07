class Web::PaymentsController < Web::ApplicationController
  skip_before_filter :basic_auth_if_staging
  skip_before_filter :verify_authenticity_token

  ## PAYANYWAY

  def paid_payanyway
    order = PaymentSystem.new(:payanyway).pay!(params)

    if order.buy_now?
      ProcessPaidOrder.call order, :buy_now
    else
      ProcessPaidOrder.call order, :regular
    end

    render text: 'SUCCESS'
  rescue PaymentSystem::SignatureError, ActiveRecord::RecordNotFound
    render text: "FAIL"
  end

  def success_payanyway
    flash_success

    order_number = params[:MNT_TRANSACTION_ID]
    order = Order.find_by(number: order_number)

    if order.buy_now?
      GoogleAnalyticsClient.buy_now_event(order, cookies)
      redirect_to success_buy_now_path(order_number: order_number)
    else
      GoogleAnalyticsClient.buy_event(order, cookies)
      redirect_to edit_account_path anchor: :orders
    end
  end

  def decline_payanyway
    order = Order.find_by number: params[:MNT_TRANSACTION_ID]
    order.try :decline

    flash_notice
    if order.buy_now?
      redirect_to new_buy_now_path
    else
      redirect_to edit_account_path anchor: :orders
    end
  end

  def cancel_payanyway
    order = Order.find_by number: params[:MNT_TRANSACTION_ID]
    order.try :cancel

    flash_error now: false
    if (order && order.buy_now?) || (!order && !signed_in?)
      redirect_to new_buy_now_path
    else
      redirect_to edit_account_path anchor: :orders
    end
  end

  ## Yandexkassa

  def check_order_yandexkassa
    request_params = request.request_parameters
    result = PaymentSystems::Yandexkassa.check_order(request_params)
    render xml: result
  end

  def payment_aviso_yandexkassa
    request_params = request.request_parameters
    result = PaymentSystems::Yandexkassa.payment_aviso(request_params)
    render xml: result
  end

  def success_yandexkassa
    order_number = params["orderNumber"]
    order = Order.find_by(number: order_number)

    if (order && order.buy_now?) || (!order && !signed_in?)
      GoogleAnalyticsClient.buy_now_event(order, cookies)
      redirect_to success_buy_now_path(order_number: order_number)
    else
      GoogleAnalyticsClient.buy_event(order, cookies)
      redirect_to edit_account_path anchor: :orders
    end
  end

  def fail_yandexkassa
    order_number = params["orderNumber"]
    order = Order.find_by(number: order_number)

    if (order && order.buy_now?)
      redirect_to new_buy_now_path
    else
      redirect_to edit_account_path anchor: :orders
    end
  end
end
