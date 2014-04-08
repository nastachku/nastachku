require 'test_helper'

class Web::Admin::UsersListsControllerTest < ActionController::TestCase
  setup do
    user = create :admin
    sign_in user
  end

  test "should get show" do
    get :show, file: Rails.root.to_s + "/users_list.csv"
    assert_response :success
  end
end
