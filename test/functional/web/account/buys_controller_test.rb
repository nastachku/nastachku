require 'test_helper'

class Web::Account::BuysControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end

  test "should put buy" do
    ticket = create :ticket_order
    discount = create :discount
    afterparty = create :afterparty_order
    put :pay, ticket_order: ticket, discount: discount, afterparty_order: afterparty
    assert_response :redirect
  end

  test "should put ticket buy" do
    post :ticket
    assert_response :redirect
  end
  test "should put afterparty buy" do
    post :afterparty
    assert_response :redirect
  end
end
