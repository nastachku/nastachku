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

  test "should action cache show" do
    cache_schedule_path = 'views/test.host' + schedule_path
    ActionController::Base.perform_caching = true
    Rails.cache.clear
    assert not(ActionController::Base.cache_store.exist?(cache_schedule_path))
    get :show
    assert ActionController::Base.cache_store.exist?(cache_schedule_path)
    ActionController::Base.perform_caching = false
  end
end
