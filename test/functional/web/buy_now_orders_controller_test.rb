require 'test_helper'

class Web::BuyNowOrdersControllerTest < ActionController::TestCase
  test '#index' do
    get :new
    assert_response :success
  end
end
