require 'test_helper'

class Web::Account::EventsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @event = create :user_event
  end

  test "should get new" do
    get :new, user_id: @user.id
    assert_response :success
  end

  test "should post create" do
    attrs = attributes_for(:user_with_events)
    post :create, user_id: @user.id, user: attrs

    assert_response :redirect
    assert @user.events.count == 1
  end

end