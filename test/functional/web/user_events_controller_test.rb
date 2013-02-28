require 'test_helper'

class Web::UserEventsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @event = create :user_event
  end

  test "should get index" do
    get :index
    assert_response :success
  end


  test "should post vote" do
    request.env["HTTP_REFERER"] = '/'
    post :vote, user_event_id: @event.id
    assert_response :redirect
    assert @user.voted?(@event)
  end
end
