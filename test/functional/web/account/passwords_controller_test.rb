require 'test_helper'

class Web::Account::PasswordsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    @token = @user.create_auth_token
  end

  test "should get edit" do
    get :edit, auth_token: @token.authentication_token
    assert_response :success
  end

  test "should not get edit" do
    get :edit, auth_token: nil
    assert_response :redirect
  end

  test "should put update password" do
    old_password = @user.password_digest
    new_password = "tgyWBJ123$%^"
    attrs = { password: new_password, password_confirmation: new_password }

    put :update, auth_token: @token.authentication_token, user: attrs
    assert_response :redirect

    @user.reload
    assert_not_equal @user.password_digest, old_password
    end
end
