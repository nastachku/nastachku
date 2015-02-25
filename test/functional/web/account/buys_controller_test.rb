require 'test_helper'

class Web::Account::BuysControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end

  test "should put buy" do
    put :pay, payment_system: :payanyway, ticket: true
    assert_response :redirect
  end
end
