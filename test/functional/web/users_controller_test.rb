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
    assert User.find_by_email(attrs[:email])
  end

end
