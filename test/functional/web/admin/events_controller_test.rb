require 'test_helper'

class Web::Admin::EventsControllerTest < ActionController::TestCase

  setup do
    @user = create :admin
    @event = create :user_event
    sign_in @user
    @workshop = @event.workshop
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
    attrs = attributes_for :user_event, workshop_id: @workshop.id, speaker_id: @user.id
    post :create, user_event: attrs
    assert_response :redirect
    event = BaseEvent.find_by_workshop_id attrs[:workshop_id]
    assert event
  end

  test "should put update" do
    attrs = attributes_for :user_event, workshop_id: @workshop.id, speaker_id: @user.id
    put :update, id: @event.id, event: attrs
    assert_response :redirect
    event = BaseEvent.find_by_title attrs[:title]
    assert event
  end

  test "should delete destroy" do
    delete :destroy, id: @event.id
    assert_response :redirect
    assert !BaseEvent.exists?(@event)
  end
end
