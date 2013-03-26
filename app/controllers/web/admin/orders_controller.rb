class Web::Admin::OrdersController < Web::Admin::ApplicationController

  def index
    query = { s: 'created_at desc' }.merge(params[:q] || {})
    @search = Order.ransack(query)
    @orders = @search.result.page(params[:page]).per(configus.pagination.admin_per_page)
  end

end
