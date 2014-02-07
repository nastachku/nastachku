class TicketOrder < Order
  def cost
    self.items_count * configus.platidoma.ticket_price
  end
end
