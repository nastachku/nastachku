module PaymentSystems
  class Payanyway
    include ActiveSupport::Configurable

    def initialize
      @id = config.id
      @currency_code = config.currency
      @test_mode = config.test_mode
      @integrity_check_code = config.integrity_check_code
    end

    def pay_url(order)
      amount = format_amount order.cost
      signature = sign_payment_request order.number, amount

      params = {
        :MNT_ID => @id,
        :MNT_TRANSACTION_ID => order.number,
        :MNT_CURRENCY_CODE => @currency_code,
        :MNT_TEST_MODE => @test_mode,
        :MNT_AMOUNT => amount,
        :MNT_SIGNATURE => signature
      }

      uri = Addressable::URI.heuristic_parse 'https://www.moneta.ru/assistant.htm' # TODO: move to config
      uri.query_values = params
      uri.to_s
    end

    def pay!(params)
      order = Order.find_by! number: params[:MNT_TRANSACTION_ID]
      transaction_id = order.number
      amount = format_amount order.cost

      validate_pay_request_signature!(
        params[:MNT_SIGNATURE],
        operation_id: params[:MNT_OPERATION_ID],
        transaction_id: transaction_id,
        amount: amount
      )

      order
    end

    private
    def validate_pay_request_signature!(their_signature, operation_id:, transaction_id:, amount:)
      our_signature = Digest::MD5.hexdigest "#{@id}#{transaction_id}#{operation_id}#{amount}#{@currency_code}#{@test_mode}#{@integrity_check_code}"

      log "Invalid signature. their_signature: '#{their_signature}', operation_id: '#{operation_id}', transaction_id '#{transaction_id}', amount: '#{amount}'"
      raise PaymentSystem::SignatureError unless our_signature == their_signature
    end

    def validate_amount!(order_amount, request_amount)
      raise PaymentSystem::InvalidAmountError unless order_amount == request_amount
    end

    def sign_payment_request(transaction_id, amount)
      Digest::MD5.hexdigest "#{@id}#{transaction_id}#{amount}#{@currency_code}#{@test_mode}#{@integrity_check_code}"
    end

    def format_amount(number)
      sprintf '%.2f', number # 5 => 5.00
    end

    def log(message)
      Rails.logger.tagged('PAYMENT SYSTEM', 'PAYANYWAY') { Rails.logger.warn(message) }
    end

  end
end
