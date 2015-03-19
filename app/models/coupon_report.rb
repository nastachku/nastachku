class CouponReport
  attr_reader :coupon

  def initialize(coupon)
    @coupon = coupon
  end

  def orders
    @orders ||= Order.where(coupon_id: coupon.id)
  end

  def orders_paid
    orders.paid
  end

  def orders_sum_with_discount
    orders_paid.reduce(0) do |sum, order|
      sum += order.cost
    end
  end

  def orders_sum_without_discount
    orders_paid.reduce(0) do |sum, order|
      sum += order.full_cost
    end
  end

  def coupons_discount
    orders_paid.reduce(0) do |sum, order|
      sum += order.coupon_discount_value
    end
  end

  def campaign_discount
    orders_paid.reduce(0) do |sum, order|
      sum += order.campaign_discount_value
    end
  end

  def partners_commission
    orders_paid.reduce(0) do |sum, order|
      sum += order.partner_commission_value
    end
  end
end
