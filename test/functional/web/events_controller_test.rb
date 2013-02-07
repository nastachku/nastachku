require 'test_helper'

class Web::EventsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end
  
  test "should get new" do
    get :new, user_id: @user.id
    assert_response :success
  end

  test "should post create" do
    post :create, user_id: @user.id, user: attributes_for(:user_with_events)
    
    assert_response :redirect
    assert @user.events.count == 1
  end
end
