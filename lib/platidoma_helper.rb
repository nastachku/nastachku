module PlatidomaHelper
  # TODO: заменить здесь все на использование PaymentSystems::Platidoma

  def platidoma_client
    params = {
      shop_id: PaymentSystems::Platidoma.config.shop_id,
      login: PaymentSystems::Platidoma.config.login,
      gate_password: PaymentSystems::Platidoma.config.gate_password,
    }

    @platidoma_client ||= Platidoma::Client.new params
  end

  def build_payment_sign(order, salt)
    params = {
      amount: order.cost,
      rnd: salt
    }

    sign = platidoma_client.build_payment_sign params
  end

  def build_status_sign(order, salt)
    params = {
      rnd: salt,
      order_id: order.number,
      trans_id: order.transaction_id,
      amount: order.cost
    }

    sign = platidoma_client.build_status_sign params
  end

  def build_payment_curl(order)
    salt = rand()
    sign = build_payment_sign(order, salt)

    params = {
      amount: order.cost,
      order_id: order.number,
      email: order.user.email,
      sign: sign,
      rnd: salt
    }

    redirect_url = platidoma_client.build_payment_url params
  end

  def get_status(order)
    salt = rand()
    sign = build_status_sign(order, salt)

    params = {
      pd_shop_id: PaymentSystems::Platidoma.config.shop_id, # FIXME: эти данные уже есть в клиенте, надо использовать их
      pd_trans_id: order.transaction_id,
      pd_rnd: salt,
      pd_sign: sign
    }

    status = platidoma_client.get_status params
  end

  def status_nonpaid?(status)
    status == "nonpaid"
  end

  def update_payment_state(order)
    status = get_status(order)

    unless status_nonpaid?(status)
      state_event_hash = {
        paid: :pay,
        reverse: :cancel,
        refund: :refund,
        declined: :decline
      }

      if state_event_hash[status.to_sym] == :pay
        ProcessPaidOrder.call order, :regular
      else
        order.fire_payment_state_event(state_event_hash[status.to_sym])
      end
    end
  end
end
