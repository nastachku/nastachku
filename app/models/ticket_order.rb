class TicketOrder < Order
  extend Enumerize

  attr_accessible :type

  enumerize :type, in: [:first, :second, :full], default: :full

  validates :type, presence: true

  def cost
    self.items_count * configus.platidoma.ticket_price
  end
end
