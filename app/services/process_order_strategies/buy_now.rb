module ProcessOrderStrategies
  class BuyNow
    attr_reader :order

    def initialize(order)
      @order = order
    end

    def call
      # FIXME
      order.tickets.each do |ticket|
        attrs = TicketCodeGenerator.call(
          count: 1,
          category: "participant",
          distributor_id: distributor.id,
          kind: "ticket",
          price: ticket.price)
        TicketCode.create attrs.first.merge(ticket: ticket)
      end

      order.afterparty_tickets.each do |ticket|
        attrs = TicketCodeGenerator.call(
          count: 1,
          category: "participant",
          distributor_id: distributor.id,
          kind: "afterparty_ticket",
          price: ticket.price)
        TicketCode.create attrs.first.merge(afterparty_ticket: ticket)
      end

      order.pay!
    end

    def self.call(*args)
      new(*args).call
    end

    private

    def distributor
      @distributor ||= Distributor.find_by!(title: 'nastachku.ru')
    end
  end
end
