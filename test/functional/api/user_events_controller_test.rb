require 'test_helper'

class Api::UserEventsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @event = create :user_event
  end

  test "should post vote" do
    post :vote, format: :json, user_event_id: @event.id
    assert_response :success
    assert @user.voted?(@event)
  end
end