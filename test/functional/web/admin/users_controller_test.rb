require 'test_helper'

class Web::Admin::UsersControllerTest < ActionController::TestCase
  setup do
    user = create :admin
    sign_in user
    @user = create :user
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    attrs = attributes_for :user
    get :create, user: attrs
    assert_response :redirect
  end

  test "should get show" do
    get :show, id: @user
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should get update" do
    attrs = attributes_for :user
    get :update, id: @user, user: attrs
    assert_response :redirect
  end

  test "should get destroy" do
    get :destroy, id: @user
    assert_response :redirect
    assert !User.exists?(@user)
  end
  
end
