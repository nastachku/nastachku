require 'test_helper'

class Web::Account::BuysControllerTest < ActionController::TestCase
  test "should post create" do
    put :pay
    assert_response :redirect
  end

  test "should put ticket buy" do
    post :ticket
    assert_response :redirect
  end
  test "should put afterparty buy" do
    post :afterparty
    assert_response :redirect
  end
end
