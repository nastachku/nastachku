require 'test_helper'

class Web::Admin::UsersControllerTest < ActionController::TestCase
  setup do
    user = create :admin
    sign_in user
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
    attributes = attributes_for :user
    post :create, user: attributes

    assert_response :redirect
    assert_equal attributes[:email], User.last.email
  end

  test "should not post create" do
    attributes = attributes_for :user
    attributes[:email] = nil
    post :create, user: attributes
    assert_response :success
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
    attributes = attributes_for :user
    put :update, id: @user, user: attributes
    @user.reload
    assert_equal attributes[:email], @user.email
  end

  test "should not put update" do
    attributes = attributes_for :user
    attributes[:email] = nil
    put :update, id: @user, user: attributes
    assert_response :success
  end

  test "should delete destroy" do
    delete :destroy, id: @user
    assert_response :redirect
    assert !User.exists?(@user)
  end

end
