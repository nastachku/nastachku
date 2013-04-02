require 'test_helper'

class Api::HallsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    @hall_first = create :hall
    @hall_second = create :hall
  end

  test "should put sort" do
    @params = {ids: [@hall_second.id, @hall_first.id], format: :json}
    put :sort, @params

    assert_response :success

    @hall_first.reload
    @hall_second.reload

    assert_equal 0, @hall_second.position_sorting
    assert_equal 1, @hall_first.position_sorting
  end

end