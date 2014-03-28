require 'test_helper'

class Web::UserLecturesControllerTest < ActionController::TestCase
  setup do
    @lecture = create :lecture
    @lecture.move_to_voting
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should action cache index" do
    cache_users_lectures_path = 'views/test.host' + user_lectures_path
    ActionController::Base.perform_caching = true
    Rails.cache.clear
    assert not(ActionController::Base.cache_store.exist?(cache_users_lectures_path))
    get :index
    assert ActionController::Base.cache_store.exist?(cache_users_lectures_path)
    ActionController::Base.perform_caching = false
  end
end
