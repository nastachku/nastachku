require 'test_helper'

class Web::Account::ShirtOrdersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @order = create :shirt_order
  end

  test "should post create" do
    attributes = attributes_for :shirt_order
    attributes[:user_id] = @user.id
    post :create, shirt_order: attributes

    assert_response :redirect
    assert_equal attributes[:item_size], ShirtOrder.last.item_size
  end

  test "should not post create" do
    attributes = attributes_for :shirt_order
    attributes[:item_size] = nil
    attributes[:user_id] = @user.id
    post :create, shirt_order: attributes

    assert_response :success
  end
end
