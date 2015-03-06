class Web::CouponsController < Web::ApplicationController
  def show
    coupon = Coupon.active.find_by(code: params[:id])
    if coupon
      session[:coupon_code] = coupon.code
      redirect_to coupon.url || buy_now_order_path
    else
      redirect_to root_path
    end
  end

  def create
    session[:coupon_code] = params[:coupon]
    redirect_to params[:back_url] || request.referer
  end
end
