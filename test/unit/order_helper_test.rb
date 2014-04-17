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
end
