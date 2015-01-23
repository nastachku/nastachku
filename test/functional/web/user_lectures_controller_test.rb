require 'test_helper'

class Web::UserLecturesControllerTest < ActionController::TestCase
  setup do
    @lecture = create :lecture
    @lecture.move_to_voting
  end

  test "should get index" do
    user = create :user
    sign_in user
    get :index
    assert_response :success
  end
end
