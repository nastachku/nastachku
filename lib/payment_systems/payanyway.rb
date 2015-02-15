module PaymentSystems
  class Payanyway
    include ActiveSupport::Configurable

    ORDER_PAID_AND_NOTIFIED = 200
    ORDER_WAITING_FOR_PAYMENT = 402
    ORDER_INVALID = 500

    def initialize
      # TODO: move to configuration
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

    def check_payment!(params)
      order = Order.find_by number: params[:MNT_TRANSACTION_ID]
      transaction_id = order.number
      amount = format_amount order.cost

      validate_check_request_signature! params[:MNT_SIGNATURE], transaction_id: transaction_id, amount: amount
      validate_amount! amount, params[:MNT_AMOUNT]
      signature = sign_check_response(transaction_id, amount)

      Struct.new(:id, :order_number, :result_code, :order_state, :amount, :response_signature).new(
        @id, transaction_id, result_code_for(order), order.payment_state, amount, signature
      )
    end

    def pay!(params)
      order = Order.find_by number: params[:MNT_TRANSACTION_ID]
      transaction_id = order.number
      amount = format_amount order.cost

      validate_pay_request_signature!(
        params[:MNT_SIGNATURE],
        operation_id: params[:MNT_OPERATION_ID],
        transaction_id: transaction_id,
        amount: amount
      )

      result_code = result_code_for order
      signature = sign_pay_response(transaction_id, result_code)

      Struct.new(:id, :order_number, :result_code, :response_signature).new(
        @id, transaction_id, result_code, signature
      )
    end

    private
    def validate_check_request_signature!(their_signature, transaction_id:, amount:)
      our_signature = Digest::MD5.hexdigest "CHECK#{@id}#{transaction_id}#{amount}#{@currency_code}#{@test_mode}#{@integrity_check_code}"

      raise PaymentSystem::SignatureError unless our_signature == their_signature
    end

    def validate_pay_request_signature!(their_signature, operation_id:, transaction_id:, amount:)
      our_signature = Digest::MD5.hexdigest "#{@id}#{transaction_id}#{operation_id}#{amount}#{@currency_code}#{@test_mode}#{@integrity_check_code}"

      raise PaymentSystem::SignatureError unless our_signature == their_signature
    end

    def validate_amount!(order_amount, request_amount)
      raise PaymentSystem::InvalidAmountError unless order_amount == request_amount
    end

    def sign_payment_request(transaction_id, amount)
      Digest::MD5.hexdigest "#{@id}#{transaction_id}#{amount}#{@currency_code}#{@test_mode}#{@integrity_check_code}"
    end

    def sign_check_response(transaction_id, amount)
      Digest::MD5.hexdigest "#{@id}#{transaction_id}#{amount}#{@currency_code}#{@test_mode}#{@integrity_check_code}"
    end

    def sign_pay_response(transaction_id, result_code)
      Digest::MD5.hexdigest "#{result_code}#{@id}#{transaction_id}#{@integrity_check_code}"
    end

    def result_code_for(order)
      case order.payment_state
      when 'unpaid'
        ORDER_WAITING_FOR_PAYMENT
      when 'paid'
        ORDER_PAID_AND_NOTIFIED
      else
        ORDER_INVALID
      end
    end

    def format_amount(number)
      sprintf '%.2f', number # 5 => 5.00
    end

  end
end
