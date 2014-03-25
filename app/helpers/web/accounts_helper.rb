module Web::AccountsHelper
  def user_has_no_tickets?(user)
    user.ticket_orders.paid.empty?
  end

  def user_paid_afterparty?
    current_user.afterparty_orders.each do |afterparty|
      if afterparty.paid?
        return true
      end
    end
    return false
  end
end
