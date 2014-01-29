require 'test_helper'

class Web::Admin::UsersControllerTest < ActionController::TestCase
  setup do
    user = create :admin
    sign_in user
    @attrs = attributes_for :user
    @user = create :user
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    post :create, user: @attrs
    user = User.find_by_email @attrs[:email]
    assert user
    assert_response :redirect
  end

  test "should get show" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should put update" do
    put :update, id: @user, user: @attrs
    user = User.find_by_email @attrs[:email]
    assert user
    assert_response :redirect
  end

  test "should delete destroy" do
    delete :destroy, id: @user
    assert_response :redirect
    assert !User.exists?(@user)
  end

end
