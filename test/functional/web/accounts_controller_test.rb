require 'test_helper'

class Web::AccountsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end

  test "should get edit" do
    promo_code = create :user_promo_code, user_id: @user.id
    get :edit, id: promo_code
    assert_response :success
  end

  test "should update user" do
    attrs = attributes_for :user
    put :update, user: attrs
    assert_response :redirect
  end

end
