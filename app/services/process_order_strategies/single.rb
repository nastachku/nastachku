module ProcessOrderStrategies
  class RegularOrder
    attr_reader :order

    def initialize(order)
      @order = order
    end

    def call
      order.pay!

      link_ticket_to_user
      link_afterparty_ticket_to_user

      order
    end

    def self.call(*args)
      new(*args).call
    end

    private

    def link_ticket_to_user
      # NOTE: возможно стоит проверять есть ли уже билета у пользователя
      return unless order.tickets.any?

      order.user.ticket = order.tickets.first
    end

    def link_afterparty_ticket_to_user
      # NOTE: возможно стоит проверять есть ли уже билета у пользователя
      return unless order.afterparty_tickets.any?

      order.user.afterparty_ticket = order.afterparty_tickets.first
    end
  end
end
