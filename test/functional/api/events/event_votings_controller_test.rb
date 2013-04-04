require 'test_helper'

class Api::Events::EventVotingsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @event = create :event
  end

  test "should post create" do
    post :create, format: :json, event_id: @event.id
    assert_response :success
    assert @event.event_votings.voted_by?(@user)
  end

  test "should delete destroy" do
    @event.event_votings.vote_by @user

    delete :destroy, format: :json, event_id: @event.id
    assert_response :success
    assert !@event.event_votings.voted_by?(@user)
  end


end