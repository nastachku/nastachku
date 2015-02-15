class PaymentSystem
  class SignatureError < Exception; end
  class InvalidAmountError < Exception; end

  cattr_accessor :available_systems

  def initialize(payment_system_id)
    @payment_system = system_by_id(payment_system_id).new
  end

  def pay_url(order)
    @payment_system.pay_url(order)
  end

  def check_payment(params)
    @payment_system.check_payment(params)
  end

  def pay(params)
    @payment_system.pay(params)
  end

  private
  def system_by_id(id)
    self.class.available_systems[id.to_sym] || raise("No payment system for id '#{id}'")
  end
end
