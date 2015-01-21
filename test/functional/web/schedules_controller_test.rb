require 'test_helper'

class Web::SchedulesControllerTest < ActionController::TestCase
  setup do
    @hall = create :hall
    @hall.activate
    6.times { create :workshop }
  end

  test "should get show" do
    Rails.cache.clear
    get :show
    assert_response :success
  end
end
