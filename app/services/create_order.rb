class CreateOrder
  attr_accessor :user, :order, :with_ticket, :with_afterparty_ticket, :params

  def initialize(user: nil, with_ticket: false, with_afterparty_ticket: false, params: {})
    @user = user
    @with_ticket = with_ticket
    @with_afterparty_ticket = with_afterparty_ticket
    @params = params
  end

  def call
    create_order

    add_ticket
    add_afterparty_ticket

    order.recalculate_cost!
    order.recalculate_items_count!

    order
  end

  def self.call(*args)
    new(*args).call
  end

  private
  def create_order
    self.order = Order.create params
    user.orders << order if user
  end

  def add_ticket
    return unless with_ticket

    order.tickets.create price: Pricelist.ticket_price
  end

  def add_afterparty_ticket
    return unless with_afterparty_ticket

    order.afterparty_tickets.create price: Pricelist.afterparty_ticket_price
  end
end
