class Web::Account::BuysController < Web::Account::ApplicationController
  def pay
    order = CreateOrder.call(
      user: current_user,
      tickets: !!params[:ticket] ? 1 : 0,
      coupon: current_coupon,
      afterparty_tickets: !!params[:afterparty_ticket] ? 1 : 0,
      params: {
        payment_system: params[:payment_system]
      }
    )

    if order.tickets.any? || order.afterparty_tickets.any?
      pay_url = PaymentSystem.new(params[:payment_system]).pay_url order
      redirect_to pay_url
    else
      flash_notice
      redirect_to edit_account_path anchor: :orders
    end
  end
end
