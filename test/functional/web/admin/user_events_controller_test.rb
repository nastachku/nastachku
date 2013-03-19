#require 'test_helper'
#
#class Web::Admin::UserEventsControllerTest < ActionController::TestCase
#
#  setup do
#    @user = create :admin
#    sign_in @user
#    @event = create :user_event, speaker: @user
#  end
#
#  test "should get index" do
#    get :index
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, id: @event.id
#    assert_response :success
#  end
#
#  test "should put update" do
#    attrs = attributes_for :user_event
#    put :update, id: @event.id, user_event: attrs
#    assert_response :redirect
#    event = UserEvent.find_by_title attrs[:title]
#    assert event
#  end
#
#  test "should put change_state" do
#    put :change_state, user_event_id: @event.id, event: :move_to_schedule
#    assert_response :redirect
#    event = UserEvent.find @event.id
#    assert event.in_schedule?
#  end
#end
