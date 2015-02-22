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
    post :activate, ticket_code_activation_type: attrs

    @ticket_code.reload
    assert_response :redirect
    assert @user.ticket_orders.first.transaction_id == attrs[:code]
    assert @user.ticket_orders.first.cost == @ticket_code.price
    assert @ticket_code.active?
  end

  test "should post activate uppercase" do
    attrs = {
      code: @ticket_code.code.upcase
    }
    post :activate, ticket_code_activation_type: attrs

    @ticket_code.reload
    assert_response :redirect
    assert @user.ticket_orders.first.transaction_id == attrs[:code].downcase
    assert @user.ticket_orders.first.cost == @ticket_code.price
    assert @ticket_code.active?
  end

  test "should post activate incorrect" do
    attrs = {
      code:" @ticket_code.code"
    }
    post :activate, ticket_code_activation_type: attrs

    @ticket_code.reload
    assert_response :success
    assert @ticket_code.new?
  end
end
