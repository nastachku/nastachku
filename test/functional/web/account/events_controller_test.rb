require 'test_helper'

class Web::Account::EventsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @event = create(:user_event, speaker: @user)
  end

  test "should get new" do
    get :new, user_id: @user.id
    assert_response :success
  end

  test "should post create" do
    attrs = generate(:user_with_events)
    post :create, user_id: @user.id, user: attrs

    assert_response :redirect
    event = @user.events.find_by_title(attrs[:events_attributes][1][:title])
    assert event
  end

  test "should put update" do
    attrs = attributes_for(:user_event)
    put :update, id: @event.id, user_event: attrs
    assert_response :success
    event = @user.events.find @event
    assert event.title == @event.title
  end

end