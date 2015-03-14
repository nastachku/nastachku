class TicketDecorator < Draper::Decorator
  delegate_all

  def buyer_name
    model.user.to_s.presence || model.order.customer_info[:name]
  end

  def distributor_title
    model.ticket_code.try(:distributor).try(:title)
  end
end
