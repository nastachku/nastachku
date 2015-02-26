require 'test_helper'

class Web::BuyNowOrdersControllerTest < ActionController::TestCase
  test '#index' do
    get :new
    assert_response :success
  end

  test '#create' do
    post :create, order: attributes_for(:buy_now_order), payment_system: 'payanyway'
    assert_response :redirect
  end
end
