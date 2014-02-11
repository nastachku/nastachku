require 'test_helper'

class Web::Account::OrderOptionsControllerTest < ActionController::TestCase
  test "should post create" do
    attributes = attributes_for :order_option
    post :create, order_option: attributes

    assert_equal attributes[:cost], OrderOption.last.cost
  end
end
