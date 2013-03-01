require 'test_helper'

class Api::EventsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @event = create :user_event
  end

  test "should post vote" do
    post :vote, format: :json, event_id: @event.id
    assert_response :success
    assert @user.going_to_event?(@event)
  end
end