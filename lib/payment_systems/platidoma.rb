module PaymentSystems
  class Platidoma
    include ActiveSupport::Configurable

    def platidoma_client
      params = {
        shop_id: config.shop_id,
        login: config.login,
        gate_password: config.gate_password,
      }

      @platidoma_client ||= ::Platidoma::Client.new params
    end

    def pay_url(order)
      salt = rand
      sign = payment_sign(order.cost, salt)

      params = {
        amount: order.cost,
        order_id: order.number,
        email: order.user.email,
        sign: sign,
        rnd: salt
      }

      platidoma_client.build_payment_url params
    end

    private
    def payment_sign(cost, salt)
      params = {amount: cost, rnd: salt}

      platidoma_client.build_payment_sign params
    end

  end
end
