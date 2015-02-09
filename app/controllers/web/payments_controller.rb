class Web::PaymentsController < Web::ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:check_payanyway, :paid_payanyway]

  def check_payanyway
    @result = PaymentSystem.new(:payanyway).check_payment!(params)
  end

  def paid_payanyway
    @result = PaymentSystem.new(:payanyway).pay!(params)
  end

  rescue_from PaymentSystem::SignatureError, PaymentSystem::InvalidAmountError do |exception|
    head :not_found
  end
end
