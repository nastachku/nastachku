class Web::Account::BuysController < Web::Account::ApplicationController
  def pay
    order = CreateOrder.call(
      user: current_user,
      tickets: !!params[:ticket] ? 1 : 0,
      coupon: current_coupon,
      afterparty_tickets: !!params[:afterparty_ticket] ? 1 : 0,
      params: {
        from: :account_order,
        payment_system: params[:payment_system]
      }
    )

    if order.tickets.any? || order.afterparty_tickets.any?
      payment_system = PaymentSystem.new(params[:payment_system])
      case payment_system.send_method
      when :redirect
        pay_url = payment_system.pay_url order
        redirect_to pay_url
      when :form_submit
        payment_system_template = payment_system.name
        @payment_form_params = payment_system.form_params(order)
        render payment_system_template
      else
        # whoa, how we got here?
      end
    else
      flash_notice
      redirect_to edit_account_path anchor: :orders
    end
  end
end
