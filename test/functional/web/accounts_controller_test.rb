require 'test_helper'

class Web::AccountsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end

  test "should get edit" do
    promo_code = create :user_promo_code
    get :edit
    assert_response :success
  end

  test "should update user" do
    attrs = attributes_for :user
    put :update, user: attrs
    assert_response :redirect
  end

end
