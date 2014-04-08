require 'test_helper'

class Web::Admin::UsersListsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, file: (fixture_file_upload Rails.root.to_s + "users_list.csv")
    assert_response :success
  end
end
