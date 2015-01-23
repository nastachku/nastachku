require 'test_helper'

class Web::SocialNetworksControllerTest < ActionController::TestCase

  setup do
    @auth_hash = generate(:facebook_auth_hash)
    @twitter_auth_hash = generate(:twitter_auth_hash)
    @user = create :user
  end

  test "should get authorization with facebook" do
    @user.activate
    @user.authorizations << build_authorization(@auth_hash)
    @user.save

    request.env['omniauth.auth'] = @auth_hash

    get :facebook

    assert_response :redirect
    assert signed_in?
    assert_equal current_user, @user
  end

  test "should fail authorization with facebook" do
    @user.deactivate
    @user.authorizations << build_authorization(@auth_hash)
    @user.save

    request.env['omniauth.auth'] = @auth_hash
    get :facebook

    assert_response :redirect
    assert !signed_in?
  end

  test "should get authorization with facebook on existing user" do
    @user.email = @auth_hash[:info][:email]
    @user.save

    request.env['omniauth.auth'] = @auth_hash

    get :facebook

    assert_response :redirect
    @user.reload
    assert @user.active?
    assert signed_in?
    assert !current_user.authorizations.blank?
  end

  test "should get authorization with facebook on new user" do
    request.env['omniauth.auth'] = @auth_hash
    get :facebook

    assert_response :redirect
    assert session_auth_hash
  end

  test "should fail authorization with facebook on inactive user" do
    @user.email = @auth_hash[:info][:email]
    @user.deactivate

    request.env['omniauth.auth'] = @auth_hash
    get :facebook

    assert_response :redirect
    @user.reload
    assert @user.inactive?
    assert !signed_in?
  end


  test "should get save auth_hash to session " do
    @user.activate
    sign_in @user
    clear_session_auth_hash

    request.env['omniauth.auth'] = @twitter_auth_hash

    get :twitter

    assert_response :redirect
    assert session_auth_hash

  end

  test "should not get save auth_hash to session " do
    @user.activate
    clear_session_auth_hash

    request.env['omniauth.auth'] = @twitter_auth_hash

    get :twitter

    assert_redirected_to new_session_path
  end
  test "should get failure" do
    get :failure
    assert_response :redirect
  end
end
