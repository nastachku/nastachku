require 'test_helper'

class Api::CompaniesControllerTest < ActionController::TestCase
  setup do
    @user = create :user
  end

  test "should get index" do
    get :index, format: :json, term: @user.company
    assert_response :success
  end

end
