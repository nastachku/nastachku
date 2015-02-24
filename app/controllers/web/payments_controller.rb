class Web::PaymentsController < Web::ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:paid_payanyway, :success_payanyway, :decline_payanyway, :cancel_payanyway]

  def paid_payanyway
    order = PaymentSystem.new(:payanyway).pay!(params)
    order.pay! unless order.paid?

    render text: 'SUCCESS'
  rescue PaymentSystem::SignatureError, ActiveRecord::RecordNotFound => e
    render text: 'FAIL'
  end

  def success_payanyway
    flash_success

    redirect_to edit_account_path anchor: :orders
  end

  def decline_payanyway
    order = current_user.orders.find_by number: params[:MNT_TRANSACTION_ID]
    order.try :decline

    flash_notice
    redirect_to edit_account_path anchor: :orders
  end

  def cancel_payanyway
    order = current_user.orders.find_by number: params[:MNT_TRANSACTION_ID]
    order.try :cancel

    flash_error now: false
    redirect_to edit_account_path anchor: :orders
  end

  rescue_from PaymentSystem::SignatureError, PaymentSystem::InvalidAmountError do |exception|
    head :not_found
  end
end
