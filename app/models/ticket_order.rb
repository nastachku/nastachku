class TicketOrder < Order
  extend Enumerize

  attr_accessible :day

  enumerize :day, in: [:first, :second, :full], default: :full

  validates :day, presence: true

  def cost
    self.items_count * configus.platidoma.ticket_price
  end
end
