module Web::AccountsHelper
  def ticket_type_collection
    TicketOrder.ticket_type.values
  end

  def item_size_collection
    ShirtOrder.item_size.values
  end

  def item_color_collection
    ShirtOrder.item_color.values
  end
end
