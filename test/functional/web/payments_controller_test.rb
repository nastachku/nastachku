require 'test_helper'

class Web::PaymentsControllerTest < ActionController::TestCase
  test 'redirects to buy now' do
    order = create :order, :with_tickets, user: nil, from: :buy_now
    get :success_payanyway, MNT_TRANSACTION_ID: order.number
    assert_redirected_to success_buy_now_order_path(order_number: order.number)
  end

  test 'redirects to account' do
    order = create :order, :with_tickets
    get :success_payanyway, MNT_TRANSACTION_ID: order.number
    assert_redirected_to edit_account_path(anchor: :orders)
  end
end
