require 'test_helper'

class Web::LecturesControllerTest < ActionController::TestCase

  setup do
    @lecture = create :lecture
    @lecture.move_to_schedule
  end

  test "should get index" do
    user = create :user
    sign_in user
    get :index
    assert_response :success
  end

  test "should get index with params" do
    get :index, q: { workshop_id_eq: @lecture.workshop.id }
    assert_response :success
  end
end
