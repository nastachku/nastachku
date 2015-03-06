class AddCouponToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :coupon, index: true
    add_foreign_key :orders, :coupons
  end
end
