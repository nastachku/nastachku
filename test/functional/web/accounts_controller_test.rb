require 'test_helper'

class Web::AccountsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end

  test "should get edit" do
    promo_code = create :user_promo_code, user_id: @user.id
    afterparty = create :afterparty_order
    afterparty.pay
    @user.orders << afterparty
    get :edit, id: promo_code
    assert_response :success
  end

  test "should update user" do
    attrs = attributes_for :user
    put :update, id: @user.id, user: attrs

    assert_response :redirect
    @user.reload
    assert @user.position == attrs[:position]
  end

end
