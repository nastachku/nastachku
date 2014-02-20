class OrderPayType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus

  attribute :ticket_order, TicketOrder
  attribute :shirt_order, ShirtOrder

  def cost
    if ticket_order and shirt_order
      ticket_order.cost + shirt_order.cost
    elsif ticket_order
      ticket_order.cost
    elsif shirt_order
      shirt_order.cost
    end
  end
end
