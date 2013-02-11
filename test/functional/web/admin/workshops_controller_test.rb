require 'test_helper'

class Web::Admin::WorkshopsControllerTest < ActionController::TestCase

  setup do
    user = create :admin
    sign_in user
    @workshop = create :workshop
    @attrs = attributes_for :workshop
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
    post :create, workshop: @attrs
    assert_response :redirect
    workshop = Workshop.find_by_title! @attrs[:title]
    assert workshop
  end

  test 'should get edit' do
    get :edit, id: @workshop.id
    assert_response :success
  end

  test 'should put update' do
    put :update, id: @workshop.id, workshop: @attrs
    assert_response :redirect
    workshop = Workshop.find_by_title! @attrs[:title]
    assert workshop
  end

  test 'should delete destroy' do
    delete :destroy, id: @workshop.id
    assert_response :redirect
    assert !Workshop.exists?(@workshop)
  end

end
