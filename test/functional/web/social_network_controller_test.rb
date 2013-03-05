require 'test_helper'

class Web::SocialNetworkControllerTest < ActionController::TestCase

  setup do
    @auth_hash = generate(:facebook_auth_hash)
    @user = create :user
  end

  test "should get authorization with facebook" do    
    @user.activate
    @user.authorizations << build_authorization(@auth_hash)
    @user.save

    request.env['omniauth.auth'] = @auth_hash
    get :authorization

    assert signed_in?
    assert_equal current_user, @user
    assert_response :redirect
  end

  test "should get authorization with facebook on existing user" do
    @user.email = @auth_hash[:info][:email] 
    @user.save

    request.env['omniauth.auth'] = @auth_hash
    get :authorization

    @user.reload
    assert @user.active?
    assert signed_in?
    assert current_user.authorizations
    assert_response :redirect
  end

  test "should get authorization with facebook on new user" do
    request.env['omniauth.auth'] = @auth_hash
    get :authorization

    assert session_auth_hash
    assert_response :redirect
  end

  test "should get failure" do
    get :failure
    assert_response :redirect
  end


end