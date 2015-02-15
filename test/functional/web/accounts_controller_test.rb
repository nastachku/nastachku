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
    attrs[:show_as_participant] = 1
    put :update, id: @user.id, user: attrs

    @user.reload
    assert_response :redirect
    assert @user.position == attrs[:position]
    assert @user.show_as_participant
  end

  test "should update password" do
    old_password_digest = @user.password_digest
    attrs = { password: "123456", password_confirmation: "123456" }

    put :update, id: @user.id, user: attrs

    @user.reload
    assert old_password_digest != @user.password_digest
    assert @user.try(:authenticate, attrs[:password])
  end

end
