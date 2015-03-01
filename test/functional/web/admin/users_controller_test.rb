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

  test "should get show" do
    get :show, id: @user.id

    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user.id

    assert_response :success
  end

  test "should put update" do
    attributes = attributes_for :user
    put :update, id: @user.id, user: attributes

    @user.reload

    assert { attributes[:email] == @user.email }
  end

  test "should delete destroy" do
    delete :destroy, id: @user.id

    assert_response :redirect
    assert_not User.exists?(@user.id)
  end

end
