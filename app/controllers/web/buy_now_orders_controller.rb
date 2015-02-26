class Web::BuyNowOrdersController < Web::ApplicationController
  layout "buy_now"

  def new
    @buy_now_order = BuyNowOrderType.new
  end
end
