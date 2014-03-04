module Web::AccountsHelper
  def user_has_no_tickets?(user)
    user.ticket_orders.paid.empty?
  end
end
