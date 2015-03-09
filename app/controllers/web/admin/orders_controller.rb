class Web::Admin::OrdersController < Web::Admin::ApplicationController

  def index
    query = { s: 'created_at desc' }.merge(params[:q] || {})
    @search = Order.ransack(query)
    @orders = @search.result.page(params[:page]).per(configus.pagination.admin_per_page)
  end

  def edit
    @order = Order.find params[:id]
  end

  def update
    @order = Order.find params[:id]
    if @order.update_attributes params[:order]
      redirect_to admin_orders_path
    else
      render action: :edit
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
