require 'test_helper'

class CreateOrderTest < ActiveSupport::TestCase
  def setup
    @user = create :user
  end

  test 'creates order' do
    CreateOrder.call user: @user

    assert @user.orders.count == 1
  end

  test 'creates order with ticket' do
    ticket_count = 1
    order = CreateOrder.call user: @user, tickets: ticket_count

    assert order.tickets.any?
    assert order.items_count == ticket_count
    assert order.cost == Pricelist.ticket_price * ticket_count
  end

  test 'creates order with afterparty tickets' do
    afterparty_ticket_count = 2
    order = CreateOrder.call user: @user, afterparty_tickets: afterparty_ticket_count

    assert order.afterparty_tickets.any?
    assert order.items_count == afterparty_ticket_count
    assert order.cost == Pricelist.afterparty_ticket_price * afterparty_ticket_count
  end

  test 'creates order with ticket and afterparty ticket' do
    ticket_count = 1
    afterparty_ticket_count = 2
    order = CreateOrder.call user: @user, tickets: ticket_count, afterparty_tickets: afterparty_ticket_count
    total_cost = (Pricelist.afterparty_ticket_price * afterparty_ticket_count) + (Pricelist.ticket_price * ticket_count)

    assert order.afterparty_tickets.any?
    assert order.tickets.any?
    assert order.items_count == ticket_count + afterparty_ticket_count
    assert order.cost == total_cost
  end

  test 'creates order with params' do
    order = CreateOrder.call params: { payment_system: 'blah', customer_info: {name: 'blah', phone: '1234567897', email: 'lala@example.com'} }

    assert_equal order.payment_system, 'blah'
    assert_equal order.customer_info[:email], 'lala@example.com'
  end
end
