require 'test_helper'

class Web::Account::OrdersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @order = create :afterparty_order
    @order.user = current_user
    @order.save
  end

  test "should put pay" do
    put :pay, id: @order

    assert_response :redirect
  end

  test "should post approve" do
    Platidoma::Client.any_instance.expects(:get_status).returns("paid")

    params = {
      pd_order_id: @order.number,
      pd_trans_id: 1
    }

    post :approve, params

    assert_response :redirect
    @order.reload
    assert @order.paid?
  end

  test "should post cancel" do
    Platidoma::Client.any_instance.expects(:get_status).returns("reverse")

    params = {
      pd_order_id: @order.number,
      pd_trans_id: 1
    }

    post :cancel, params

    assert_response :redirect
    @order.reload
    assert @order.canceled?
  end

  test "should post decline" do
    Platidoma::Client.any_instance.expects(:get_status).returns("declined")

    params = {
      pd_order_id: @order.number,
      pd_trans_id: 1
    }

    post :decline, params

    assert_response :redirect
    @order.reload
    assert @order.declined?
  end

  test "should put update" do
    Platidoma::Client.any_instance.expects(:get_status).returns("paid")

    put :update, id: @order

    assert_response :redirect
    @order.reload
    assert @order.paid?
  end
end
