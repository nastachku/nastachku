require 'test_helper'

class Web::Admin::HallsControllerTest < ActionController::TestCase

  setup do
    user = create :admin
    sign_in user
    @hall = create :hall
    @attrs = attributes_for :hall
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
    post :create, hall: @attrs
    assert_response :redirect
    hall = Hall.find_by_title @attrs[:title]
    assert hall
  end

  test 'should get edit' do
    get :edit, id: @hall.id
    assert_response :success
  end

  test 'should put update' do
    put :update, id: @hall.id, hall: @attrs
    assert_response :redirect
    hall = Hall.find_by_title @attrs[:title]
    assert hall
  end

  test 'should delete destroy' do
    delete :destroy, id: @hall.id
    assert_response :redirect
    assert !Hall.exists?(@hall)
  end

end
