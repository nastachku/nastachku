require 'test_helper'

class Web::SessionsControllerTest < ActionController::TestCase

  setup do
    @user = create :user
  end

  test "should authenticate" do
    attrs = { email: @user.email, password: @user.password }

    Web::SessionsController.any_instance
      .expects(:get_auth_token).returns('murder,kill')

    post :create, user_sign_in_type: attrs

    assert_response :redirect
    assert signed_in?
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get new with auth_token" do
    auth_token = @user.create_auth_token
    get :new, auth_token: auth_token.authentication_token
    assert_select '#user_sign_in_type_email' do
      assert_select "[value=?]", @user.email
    end
    assert_response :success
  end

  test "should delete destroy" do
    sign_in @user

    delete :destroy

    assert_response :redirect
    assert !signed_in?
  end

end
