require 'test_helper'

class Web::Admin::MailersControllerTest < ActionController::TestCase
  setup do
    user = create :admin
    sign_in user
    @attrs = attributes_for :user
    @user = create :user
    ActionMailer::Base.deliveries = []
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get deliver" do
    post :deliver
    assert_response :redirect
    assert_redirected_to admin_mailers_path
  end

  test "should mail sent" do
    @user.not_decide
    post :deliver
    assert_equal ActionMailer::Base.deliveries.size, 1
  end

end
