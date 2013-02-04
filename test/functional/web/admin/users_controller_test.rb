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
  
  test "should get destroy" do
    get :destroy, id: @user
    assert_response :redirect
    assert !User.exists?(@user)
  end

end
