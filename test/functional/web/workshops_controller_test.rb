require 'test_helper'

class Web::WorkshopsControllerTest < ActionController::TestCase

  setup do
    @workshop = create :workshop
  end

  test "should get show" do
    get :show, id: @workshop.id
    assert_response :success
  end

end
