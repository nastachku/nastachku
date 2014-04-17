module Web::AccountsHelper
  def user_paid_afterparty?
    current_user.afterparty_orders.select { |afterparty| afterparty.paid? }.any?
  end
end
