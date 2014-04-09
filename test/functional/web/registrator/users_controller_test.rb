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

  test "should put give_badge" do
    put :give_badge, id: @registrator
    assert_response :redirect
  end
end
