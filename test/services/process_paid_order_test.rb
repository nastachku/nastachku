require 'test_helper'

class ProcessPaidOrderTest < ActiveSupport::TestCase
  def setup
    @order = Order.create
    @order.tickets.create
    @order.afterparty_tickets.create
  end

  test 'marks as paid and links tickets to user' do
    @user = create :user
    @order.user = @user
    ProcessPaidOrder.call @order, :regular

    assert @order.paid?
    assert @user.ticket
    assert @user.afterparty_ticket
  end

  test 'creates codes for tickets in order' do
    create :distributor, :nastachku
    ProcessPaidOrder.call @order, :buy_now
    
    assert @order.paid?
    assert @order.tickets.map(&:ticket_code).present?
    assert @order.afterparty_tickets.map(&:ticket_code).present?
  end
end
