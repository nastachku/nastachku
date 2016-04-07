require Rails.root.join('lib', 'gabba', 'gabba')

module GoogleAnalyticsClient
  class << self
    def test_event(cookies = {})
      send_event("Test", "Test Event", 42, cookies)
    end

    def register_event(user, cookies = {})
      send_event("Пользователь", "Регистрация", user.id, cookies)
    end

    def buy_event(order, cookies = {})
      user = order.user

      if order.tickets.exists?
        send_event("Покупка", "Билет на конференцию", user.id, cookies)
      end

      if order.afterparty_tickets.exists?
        send_event("Покупка", "Билет на вечеринку", user.id, cookies)
      end
    end

    def buy_now_event(order = nil, cookies = {})
      if order.tickets.exists?
        send_event("Покупка", "Билет на конференцию (без регистрации)", nil, cookies)
      end

      if order.afterparty_tickets.exists?
        send_event("Покупка", "Билет на вечеринку (без регистрации)", nil, cookies)
      end
    end

    def conference_code_activation_event(user, cookies = {})
      send_event("Пользователь", "Активация кода билета на конференцию", user.id, cookies)
    end

    def party_code_activation_event(user, cookies = {})
      send_event("Пользователь", "Активация кода билета на вечеринку", user.id, cookies)
    end

    private

    def extract_cid_from_cookies(cookies = {})
      ga_cookie = cookies['_ga']
      if ga_cookie.present?
        ga_cookie.split('.')[-2, 2].try(:join, '.')
      else
        nil
      end
    end

    def send_event(category, action, label = nil, cookies = {})
      cid = extract_cid_from_cookies(cookies)
      event_params = [category, action, label, nil, false, nil, {cid: cid}]
      begin
        client = Gabba::Gabba.new("UA-38587983-1", configus.analytics.host)
        client.event(*event_params)
      rescue
        # well, it's just analytics, so let it crash
      end
    end
  end
end
