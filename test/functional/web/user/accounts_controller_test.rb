require 'test_helper'

class Web::User::AccountsControllerTest < ActionController::TestCase

  setup do
    @user = create :user

    sign_in(@user)
  end

  test "should get edit" do
    get :edit, id: @user

    assert_response :success
  end

  test "should update user" do
    attrs = attributes_for :update_user

    put :update, id: @user, user: attrs

    assert_response :redirect
  end
end
