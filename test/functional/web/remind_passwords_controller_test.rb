require 'test_helper'

class Web::RemindPasswordsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    @user.activate
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    attrs = { email: @user.email }

    post :create, user_password_remind_type: attrs

    assert_response :redirect
    assert @user.auth_tokens.any?
  end

  test "should not post create" do
    attrs = { email: @user.email }
    @user.deactivate

    post :create, user_password_remind_type: attrs
    assert_response :success
  end
end
