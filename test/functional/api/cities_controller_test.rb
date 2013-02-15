require 'test_helper'

class Api::CitiesControllerTest < ActionController::TestCase
  setup do
    @user = create :user
  end
  
  test "should get index" do

    get :index, format: :json, term: "sdfgdffhfg"
    assert_response :success
  end

end
