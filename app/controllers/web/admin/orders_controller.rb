class Web::Admin::OrdersController < Web::Admin::ApplicationController

  def index
    @orders = Order.web
  end

end
