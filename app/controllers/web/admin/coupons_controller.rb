class Web::Admin::CouponsController < Web::Admin::ApplicationController
  def index
    @coupons = Coupon.page(params[:page])
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def new
    @coupon = AdminCouponType.new
  end

  def create
    @coupon = AdminCouponType.new(params[:coupon])
    if @coupon.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def edit
    @coupon = AdminCouponType.find(params[:id])
  end

  def update
    @coupon = AdminCouponType.find(params[:id])
    if @coupon.update(params[:coupon])
      redirect_to action: :index
    else
      render action: :edit
    end
  end
end
