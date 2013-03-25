class Web::Admin::OrdersController < Web::Admin::ApplicationController

  def index
    query = params[:q] || { s: 'created_at desc' }
    @search = Order.ransack(query)
    @orders = @search.result.page(params[:page]).per(configus.pagination.admin_per_page)
  end

end
