class Web::Admin::OrdersController < Web::Admin::ApplicationController

  def index
    @search = Order.ransack(params[:q])
    if params[:q]
      @orders = @search.result.page(params[:page]).per(configus.pagination.admin_per_page)
    else
      @orders = @search.result.web.page(params[:page]).per(configus.pagination.admin_per_page)
    end
  end

end
