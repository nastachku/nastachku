require 'test_helper'

class Web::Admin::UsersListsControllerTest < ActionController::TestCase
  setup do
    user = create :admin
    sign_in user
    @users_list = create :users_list
  end

  test "should get show" do
    get :show, id: @users_list
    assert_response :success
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should post create' do
    attributes = attributes_for :users_list
    post :create, users_list: attributes
    assert_response :redirect
  end

  test 'should delete destroy' do
    @users_list = create :users_list
    delete :destroy, id: @users_list
    assert_response :redirect
    assert !UsersList.exists?(@users_list)
  end
end
