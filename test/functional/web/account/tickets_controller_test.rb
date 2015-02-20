require 'test_helper'

class Web::Account::TicketsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @ticket_code = create :ticket_code
  end

  test "should post activate" do
    attrs = {
      code: @ticket_code.code
    }
    post :activate, ticket_code: attrs

    @ticket_code.reload
    assert_response :redirect
    assert @user.ticket_orders.first.transaction_id == attrs[:code]
    assert @user.ticket_orders.first.cost == @ticket_code.price
    assert @ticket_code.active?
  end
end
