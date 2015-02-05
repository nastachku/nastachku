require 'test_helper'

class Web::SocialNetworksControllerTest < ActionController::TestCase

  setup do
    @facebook_auth_hash = generate(:facebook_auth_hash)
    @vkontakte_auth_hash = generate(:vkontakte_auth_hash)
    @twitter_auth_hash = generate(:twitter_auth_hash)
    @user = create :user
  end

  test "should get authorization with facebook" do
    @user.activate
    @user.authorizations << build_authorization(@facebook_auth_hash)
    @user.save

    request.env['omniauth.auth'] = @facebook_auth_hash

    get :auth, provider: :facebook

    assert_response :redirect
    assert signed_in?
    assert_equal current_user, @user
  end

  test "should fail authorization with facebook" do
    @user.deactivate
    @user.authorizations << build_authorization(@facebook_auth_hash)
    @user.save

    request.env['omniauth.auth'] = @facebook_auth_hash
    get :auth, provider: :facebook

    assert_response :redirect
    assert !signed_in?
  end

  test "should get authorization with facebook on existing user" do
    @user.email = @facebook_auth_hash[:info][:email]
    @user.save

    request.env['omniauth.auth'] = @facebook_auth_hash

    get :auth, provider: :facebook

    assert_response :redirect
    @user.reload
    assert @user.active?
    assert signed_in?
    assert current_user.authorizations.where(provider: 'facebook').any?
  end

  test "should get authorization with vkontakte on existing user" do
    @user.email = @vkontakte_auth_hash[:info][:email]
    @user.save

    request.env['omniauth.auth'] = @vkontakte_auth_hash

    get :auth, provider: :vkontakte

    assert_response :redirect
    @user.reload
    assert @user.active?
    assert signed_in?
    assert current_user.authorizations.where(provider: 'vkontakte').any?
  end

  test "should get authorization with twitter on existing user" do
    @user.activate
    @user.authorizations << build_authorization(@twitter_auth_hash)
    @user.save

    request.env['omniauth.auth'] = @twitter_auth_hash

    get :auth, provider: :twitter

    assert_response :redirect
    assert signed_in?
    assert_equal current_user, @user
  end

  test "should get authorization with vkontakte on new user" do
    request.env['omniauth.auth'] = @vkontakte_auth_hash
    get :auth, provider: :vkontakte

    assert_response :redirect
    assert session_auth_hash
  end

  test "should get authorization with facebook on new user" do
    request.env['omniauth.auth'] = @facebook_auth_hash
    get :auth, provider: :facebook

    assert_response :redirect
    assert session_auth_hash
  end

  test "should get authorization with twitter on new user" do
    request.env['omniauth.auth'] = @twitter_auth_hash
    get :auth, provider: :twitter

    assert_response :redirect
    assert session_auth_hash
  end

  test "should fail authorization with facebook on inactive user" do
    @user.email = @facebook_auth_hash[:info][:email]
    @user.deactivate

    request.env['omniauth.auth'] = @facebook_auth_hash
    get :auth, provider: :facebook

    assert_response :redirect
    @user.reload
    assert @user.inactive?
    assert !signed_in?
  end

  test "should get failure" do
    get :failure
    assert_response :redirect
  end
end
