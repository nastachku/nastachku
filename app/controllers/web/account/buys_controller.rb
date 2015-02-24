class Web::Account::BuysController < Web::Account::ApplicationController
  def pay
    order = CreateOrder.call(
      user: current_user,
      with_ticket: !!params[:ticket],
      with_afterparty_ticket: !!params[:afterparty_ticket],
      params: {
        payment_system: params[:payment_system]
      }
    )

    pay_url = PaymentSystem.new(params[:payment_system]).pay_url order
    redirect_to pay_url
  end
end
