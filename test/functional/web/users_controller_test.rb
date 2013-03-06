require 'test_helper'

class Web::UsersControllerTest < ActionController::TestCase
  setup do
    create :user
  end

  test "should get index" do
    get :index

    assert_response :success
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should create user" do
    attrs = attributes_for :user
    attrs[:password_confirmation] = attrs[:password]
    attrs[:process_personal_data] = "1"

    post :create, user: attrs

    assert_response :redirect
    user = User.find_by_email(attrs[:email])
    assert user
  end

  test "should create user by social network" do
    attrs = attributes_for :user
    attrs[:password_confirmation] = attrs[:password]
    attrs[:process_personal_data] = "1"

    @auth_hash = generate(:facebook_auth_hash)
    request.env['omniauth.auth'] = @auth_hash
    save_auth_hash_to_session

    post :create, user: attrs

    assert_response :redirect
    user = User.find_by_email(attrs[:email])
    assert user
    assert user.authorizations
  end

end
