module GoogleAnalyticsClient
  extend GoogleAnalyticsClient::GaEvent

  class << self
    def test_event(cookies = {})
      send_event("Test", "Test Event", 42, nil, cookies)
    end

    def register_event(user, cookies = {})
      send_event("Пользователь", "Регистрация", user.id, nil, cookies)
    end

    def buy_event(order, cookies = {})
      user = order.user

      if order.tickets.exists?
        send_event("Покупка", "Билет на конференцию", user.id, nil, cookies)
      end

      if order.afterparty_tickets.exists?
        send_event("Покупка", "Билет на вечеринку", user.id, nil, cookies)
      end
    end

    def buy_now_event(order = nil, cookies = {})
      if order.tickets.exists?
        send_event("Покупка", "Билет на конференцию (без регистрации)", nil, nil, cookies)
      end

      if order.afterparty_tickets.exists?
        send_event("Покупка", "Билет на вечеринку (без регистрации)", nil, nil, cookies)
      end
    end

    def conference_code_activation_event(user, cookies = {})
      send_event("Пользователь", "Активация кода билета на конференцию", user.id, nil, cookies)
    end

    def party_code_activation_event(user, cookies = {})
      send_event("Пользователь", "Активация кода билета на вечеринку", user.id, nil, cookies)
    end
  end
end
