class ChangeOrdersData < ActiveRecord::Migration
  class Order < ActiveRecord::Base
    self.inheritance_column = :_fake

    has_many :tickets
    belongs_to :user
    def paid?
      payment_state == 'paid'
    end
  end

  class Ticket < ActiveRecord::Base
    attr_accessible :price
    belongs_to :order
    belongs_to :user
  end

  class User < ActiveRecord::Base
    has_many :orders
    has_one :ticket
  end

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
