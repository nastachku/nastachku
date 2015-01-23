require 'test_helper'

class Web::Admin::EventsControllerTest < ActionController::TestCase

  setup do
    @user = create :admin
    @event = create :event
    sign_in @user
    #@workshop = @event.workshop
  end

  test "should get index" do
    get :index
    assert_response :success
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event.id
    assert_response :success
  end

  test "should post create" do
    attrs = attributes_for :event #, user_id: @user.id
    post :create, event: attrs
    assert_response :redirect
    event = Event.find_by_title attrs[:title]
    assert event
  end

  test "should put update" do
    attrs = attributes_for :event #, user_id: @user.id
    put :update, id: @event.id, event: attrs
    assert_response :redirect
    event = Event.find_by_title attrs[:title]
    assert event
  end

  test "should delete destroy" do
    delete :destroy, id: @event.id
    assert_response :redirect
    assert !Event.exists?(@event.id)
  end
end
