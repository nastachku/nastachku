class ProcessPaidOrder
  STRATEGIES = {
    regular: ProcessOrderStrategies::RegularOrder,
    buy_now: ProcessOrderStrategies::BuyNow
  }
  attr_reader :user, :order

  def initialize(order, strategy)
    @order = order
    @strategy = STRATEGIES.fetch(strategy)
  end

  def call
    @strategy.call order
  end

  def self.call(*args)
    new(*args).call
  end
end
