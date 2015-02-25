require 'test_helper'

class Web::Admin::TicketsControllerTest < ActionController::TestCase
  setup do
    @user = create :admin
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
