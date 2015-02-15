require 'test_helper'
require "#{Rails.root}/lib/order_helper"

class OrderHelperTest < ActiveSupport::TestCase
  include OrderHelper

  test "put paid status with other orders" do
    user = create :user
    order = create :order
    order.cost = TicketOrder.ticket_price
    order.save
    order.pay
    user.orders << order
    user.orders << (create :ticket_order)
    put_paid_status_with_other_orders order
    assert user.orders.last.paid?
  end
end
