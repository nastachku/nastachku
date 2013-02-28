require 'test_helper'

class Web::Account::EventsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end

  test "should get new" do
    get :new, user_id: @user.id
    assert_response :success
  end

  test "should post create" do
    attrs = attributes_for(:user_with_events)
    post :create, user_id: @user.id, user: attrs

    assert_response :redirect
    event = @user.events.find_by_title(attrs[:events_attributes][1][:title])
    assert event
  end

end