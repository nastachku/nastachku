class Web::PaymentsController < Web::ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:check_payanyway, :paid_payanyway]

  def check_payanyway
    @result = PaymentSystem.new(:payanyway).check_payment!(params)
  end

  def paid_payanyway
    order = PaymentSystem.new(:payanyway).pay!(params)
    order.pay unless order.paid?

    render text: 'SUCCESS', content_type: 'text/plain'
  rescue PaymentSystem::SignatureError, ActiveRecord::RecordNotFound => e
    render text: 'FAIL', content_type: 'text/plain'
  end

  rescue_from PaymentSystem::SignatureError, PaymentSystem::InvalidAmountError do |exception|
    head :not_found
  end
end
