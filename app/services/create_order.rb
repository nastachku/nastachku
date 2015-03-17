class CreateOrder
  attr_accessor :user, :order, :tickets, :afterparty_tickets, :params, :coupon

  def initialize(user: nil, tickets: 0, afterparty_tickets: 0, coupon: nil, params: {})
    @user = user
    @coupon = coupon
    @tickets = tickets
    @afterparty_tickets = afterparty_tickets
    @params = params
  end

  def call
    create_order

    add_tickets
    add_afterparty_tickets

    order.campaign = Campaign.suitable_for(order.tickets.count, order.afterparty_tickets.count, Time.current)

    order.recalculate_cost!
    order.recalculate_items_count!

    order.reload
  end

  def self.call(*args)
    new(*args).call
  end

  private

  def create_order
    self.order = Order.create params
    self.order.coupon = coupon

    user.orders << order if user
  end

  def add_tickets
    return unless tickets > 0

    tickets.times do
      order.tickets.create price: Pricelist.ticket_price
    end
  end

  def add_afterparty_tickets
    return unless afterparty_tickets > 0

    afterparty_tickets.times do
      order.afterparty_tickets.create price: Pricelist.afterparty_ticket_price
    end
  end
end
