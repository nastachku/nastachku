class Web::PaymentsController < Web::ApplicationController
  skip_before_filter :basic_auth_if_staging, only: [:paid_payanyway, :success_payanyway, :decline_payanyway, :cancel_payanyway]
  skip_before_filter :verify_authenticity_token, only: [:paid_payanyway, :success_payanyway, :decline_payanyway, :cancel_payanyway]

  def paid_payanyway
    order = PaymentSystem.new(:payanyway).pay!(params)
    if order.user
      ProcessPaidOrder.call order, :regular
    else
      ProcessPaidOrder.call order, :buy_now
    end

    render text: 'SUCCESS'
  rescue PaymentSystem::SignatureError, ActiveRecord::RecordNotFound => e
    render text: 'FAIL'
  end

  def success_payanyway
    flash_success

    order_number = params[:MNT_TRANSACTION_ID]
    order = Order.find_by(number: order_number)
    if order.user
      redirect_to edit_account_path anchor: :orders
    else
      redirect_to success_buy_now_order_path order_number: order_number
    end
  end

  def decline_payanyway
    order = Order.find_by number: params[:MNT_TRANSACTION_ID]
    order.try :decline

    flash_notice
    redirect_to edit_account_path anchor: :orders
  end

  def cancel_payanyway
    order = Order.find_by number: params[:MNT_TRANSACTION_ID]
    order.try :cancel

    flash_error now: false
    redirect_to edit_account_path anchor: :orders
  end
end
