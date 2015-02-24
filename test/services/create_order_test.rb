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
    order = CreateOrder.call user: @user, with_ticket: true

    assert order.tickets.any?
    assert order.items_count == 1
    assert order.cost == Pricelist.ticket_price
  end

  test 'creates order with afterparty ticket' do
    order = CreateOrder.call user: @user, with_afterparty_ticket: true

    assert order.afterparty_tickets.any?
    assert order.items_count == 1
    assert order.cost == Pricelist.afterparty_ticket_price
  end

  test 'creates order with ticket and afterparty ticket' do
    order = CreateOrder.call user: @user, with_ticket: true, with_afterparty_ticket: true
    total_cost = Pricelist.afterparty_ticket_price + Pricelist.ticket_price

    assert order.afterparty_tickets.any?
    assert order.tickets.any?
    assert order.items_count == 2
    assert order.cost == total_cost
  end

  test 'creates order with params' do
    order = CreateOrder.call params: { payment_system: 'blah' }

    assert order.payment_system == 'blah'
  end
end
