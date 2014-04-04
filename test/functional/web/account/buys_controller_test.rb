require 'test_helper'

class Web::Account::BuysControllerTest < ActionController::TestCase
  test "should post create" do
    put :pay
    assert_response :redirect
  end

  test "should put ticket buy" do
    get :ticket_buy
    assert_response :redirect
  end
end
