require 'test_helper'

class Web::Account::AfterpartyOrdersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @attrs = attributes_for :afterparty_order
    @order = create :afterparty_order
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    old_orders_count = Order.count
    post :create, afterparty_order: @attrs

    assert_response :redirect
    order = current_user.orders.find_by_count(@attrs[:count])
    assert order
  end

end
