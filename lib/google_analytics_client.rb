module GoogleAnalyticsClient
  class << self
    def test_event
      send_event("Test", "Test Event", nil, 42)
    end

    def register_event(user)
      send_event("Пользователь", "Регистрация", nil, user.id)
    end

    def buy_event(user)
      send_event("Test", "Test Event", nil, user.id)
    end

    def buy_now_event
      send_event("Test", "Test Event", nil, nil)
    end

    def code_activation_event(user)
      send_event("Test", "Test Event", nil, user.id)
    end

    private

    def send_event(*event_params)
      begin
        client = Gabba::Gabba.new("UA-38587983-1", config.analytics_host)
        client.event(*event_params)
      rescue
        # well, it's just analytics, so let it crash
      end
    end
  end
end
