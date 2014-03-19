require 'test_helper'

class Web::SchedulesControllerTest < ActionController::TestCase
  setup do
    @hall = create :hall
    @hall.activate
  end
  test "should get show" do
    get :show
    assert_response :success
  end
end
