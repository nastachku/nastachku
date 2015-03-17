json.prices do
  if @order.campaign
    json.campaign do
      json.name @order.campaign.name
      json.discount_amount @order.campaign.discount_amount
    end
  end
  if @order.coupon
    json.coupon do
      json.code @order.coupon.code
      json.discount @order.coupon.discount
    end
  end
  json.campaign_discount_value @order.campaign_discount_value
  json.cost @order.cost
  json.coupon_discount_value @order.coupon_discount_value
  json.full_cost @order.full_cost
end
