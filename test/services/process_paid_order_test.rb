require 'test_helper'

class ProcessPaidOrderTest < ActiveSupport::TestCase
  def setup
    @user = create :user
    @order = @user.orders.create
    @order.tickets.create
    @order.afterparty_tickets.create
  end

  test 'marks as paid and links tickets to user' do
    ProcessPaidOrder.call @order

    assert @order.paid?
    assert @user.ticket
    assert @user.afterparty_ticket
  end
end
