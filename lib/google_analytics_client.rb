module GoogleAnalyticsClient
  class << self
    def test_event
      send_event("Test", "Test Event", 42)
    end

    def register_event(user)
      send_event("Пользователь", "Регистрация", user.id)
    end

    def buy_event(order)
      if order.tickets.exists?
        send_event("Покупка", "Билет на конференцию", user.id)
      end

      if order.afterparty_tickets.exists?
        send_event("Покупка", "Билет на вечеринку", user.id)
      end
    end

    def buy_now_event
      if order.tickets.exists?
        send_event("Покупка", "Билет на конференцию (без регистрации)", nil)
      end

      if order.afterparty_tickets.exists?
        send_event("Покупка", "Билет на вечеринку (без регистрации)", nil)
      end
    end

    def conference_code_activation_event(user)
      send_event("Пользователь", "Активация кода билета на конференцию", user.id)
    end

    def party_code_activation_event(user)
      send_event("Пользователь", "Активация кода билета на вечеринку", user.id)
    end

    private

    def send_event(*event_params)
      begin
        client = Gabba::Gabba.new("UA-38587983-1", configus.analytics.host)
        client.event(*event_params)
      rescue
        # well, it's just analytics, so let it crash
      end
    end
  end
end
