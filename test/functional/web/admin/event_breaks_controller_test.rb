require 'test_helper'

class Web::Admin::EventBreaksControllerTest < ActionController::TestCase

  setup do
    user = create :admin
    sign_in user
    @break_time = create :break
    @attrs = attributes_for :break, hall_id: @break_time.hall.id
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @break_time.id
    assert_response :success
  end

  test "should post create" do
    post :create, event_break: @attrs
    assert_response :redirect
    break_time = Event::Break.find_by_title @attrs[:title]
    assert break_time
  end

  test "should put update" do
    put :update, id: @break_time.id, event_break: @attrs
    assert_response :redirect
    break_time = Event::Break.find_by_title @attrs[:title]
    assert break_time
  end

  test "should delete destroy" do
    delete :destroy, id: @break_time.id
    assert_response :redirect
    assert !Event::Break.exists?(@break_time)
  end

end
