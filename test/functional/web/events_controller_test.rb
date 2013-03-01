require 'test_helper'

class Web::EventsControllerTest < ActionController::TestCase

  setup do
    @event = create :user_event
  end

  test "should get :index" do
    get :index
    assert_response :success
  end

  test "should get :index with params" do
    get :index, q: { workshop_id_eq: @event.workshop.id }
    assert_response :success
  end

end
