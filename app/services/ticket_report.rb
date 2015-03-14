class TicketReport
  def initialize(ticket_type, filename)
    @ticket_class = ticket_type.to_s.classify.constantize
    @filename = filename
  end

  def self.generate(*args)
    new(*args).generate
  end

  def generate
    header = ['#', 'Order ID', 'User ID', 'User name', 'User company', 'Price', 'State', 'Date', 'Payment system', 'Transaction ID', 'Distributor', 'Code']

    tickets_data = tickets.map.each_with_index do |ticket, i|
      [
        i,
        ticket.order_id,
        ticket.user_id,
        ticket.buyer_name,
        ticket.user.try(:company),
        ticket.price,
        ticket.order.try(:payment_state),
        ticket.created_at,
        ticket.order.try(:payment_system),
        ticket.order.try(:transaction_id),
        ticket.distributor_title,
        ticket.ticket_code.to_s
      ]
    end.unshift header

    write_to_csv tickets_data
  end

  def tickets
    activated_tickets = @ticket_class.joins(:ticket_code).merge(TicketCode.activated)
    bought_tickets = @ticket_class.joins(:order).merge(Order.except_unpaid)

    sorted_tickets = (activated_tickets + bought_tickets).uniq.sort { |a, b| a.id <=> b.id }
    TicketDecorator.decorate_collection sorted_tickets
  end

  def write_to_csv(tickets_data)
    CSV.open(@filename, 'w') do |csv|
      tickets_data.each { |ticket_data| csv << ticket_data }
    end
  end
end
