require 'test_helper'

class Web::SessionsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
  end

  test "should log in" do
    user_attributes = {email: @user.email, password: @user.password }

    post :create, user: user_attributes

    assert_response :redirect
  end

end
