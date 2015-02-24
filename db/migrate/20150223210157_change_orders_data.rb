class ChangeOrdersData < ActiveRecord::Migration
  # class Ticket < ActiveRecord::Base
  # end

  # class Order < ActiveRecord::Base
  # end

  def up
    Order.find_each do |order|
      ticket = Ticket.create! price: order.cost
      ticket.order = order
      ticket.user = order.user if order.paid?
      ticket.save
    end
  end

  def down
    Ticket.destroy_all
  end
end
