require 'test_helper'

class Web::Admin::OrdersControllerTest < ActionController::TestCase

  setup do
    user = create :admin
    @order = create :order
    sign_in user
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should put update" do
    attributes = attributes_for :order
    put :update, id: @order, order: attributes
    assert_response :redirect
  end
end
