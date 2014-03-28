require 'test_helper'

class Web::LecturesControllerTest < ActionController::TestCase

  setup do
    @lecture = create :lecture
    @lecture.move_to_schedule
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get index with params" do
    get :index, q: { workshop_id_eq: @lecture.workshop.id }
    assert_response :success
  end
  
  test "should action cache index" do
    cache_lectures_path = 'views/test.host' + lectures_path
    ActionController::Base.perform_caching = true
    Rails.cache.clear
    assert not(ActionController::Base.cache_store.exist?(cache_lectures_path))
    get :index
    assert ActionController::Base.cache_store.exist?(cache_lectures_path)
    ActionController::Base.perform_caching = false
  end
end
