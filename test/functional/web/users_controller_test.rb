require 'test_helper'

class Web::UsersControllerTest < ActionController::TestCase
  setup do
    user = create :user

    sign_in(user)
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should create user" do
    attrs = attributes_for :user

    post :create, user: attrs

    assert_response :redirect
    assert_equal attrs[:email], User.last.email
  end

  test "should show user" do
    user = create :user

    get :show, id: user

    assert_response :success
  end

  test "should get edit" do
    user = create :user

    get :edit, id: user

    assert_response :success
  end

  test "should update user" do
    user  = create :user
    attrs = attributes_for :update_user

    put :update, id: user, user: attrs

    assert_response :redirect
  end

  test "should destroy user" do
    user = create :user

    delete :destroy, id: user

    assert_response :redirect
    assert !User.exists?(user)
  end

end
