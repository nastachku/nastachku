require 'test_helper'

class Web::Account::LecturesControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @user_attrs = generate(:user_with_lectures)
  end

  test '#new' do
    get :new
    assert_response :success
  end

  test '#create' do
    post :create, user: @user_attrs
    assert_response :redirect
  end
end
