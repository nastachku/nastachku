require 'test_helper'

class Web::Registrator::UsersControllerTest < ActionController::TestCase
  setup do
    @registrator = create :registrator
    sign_in @registrator
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
