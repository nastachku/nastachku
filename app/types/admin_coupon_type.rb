class AdminCouponType < Coupon
  include BasicType

  attr_accessible :code, :partner, :discount, :commission, :url, :state_event
  permit :code, :partner, :discount, :commission, :url, :state_event
end
