require 'test_helper'
require "#{Rails.root}/lib/order_helper"

class OrderHelperTest < ActiveSupport::TestCase
  include OrderHelper
  test "pay user if ticket" do
    order = create :order
    order.type = "TicketOrder"
    order.save
    pay_user_if_ticket order
    assert order.user.paid_part?
  end

  test "ticket order one of two items" do
    order = create :ticket_order
    order.cost = configus.platidoma.ticket_price
    order.save
    assert ticket_order_one_of_two_items? order, configus.platidoma.afterparty_price + configus.platidoma.ticket_price
  end

  test "afterparty order one of two items" do
    order = create :afterparty_order
    order.cost = configus.platidoma.afterparty_price
    order.save
    assert afterparty_one_of_two_items? order, configus.platidoma.afterparty_price + configus.platidoma.ticket_price
  end

  test "put paid status with other orders" do
    user = create :user
    order = create :order
    order.cost = configus.platidoma.ticket_price
    order.save
    order.pay
    user.orders << order
    user.orders << (create :ticket_order)
    put_paid_status_with_other_orders order
    assert user.orders.last.paid?
  end
end
