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

  test "should get broadcast" do
    post :broadcast
    assert_response :redirect
    assert_redirected_to admin_mailers_path
  end
  
  test "should get broadcast_to_not_attended" do
    post :broadcast_to_not_attended
    assert_response :redirect
    assert_redirected_to admin_mailers_path
  end

  test "should get broadcast_to_admins" do
    post :broadcast_to_admins
    assert_response :redirect
    assert_redirected_to admin_mailers_path
  end
  
  test "should mail sent" do
    # @user.not_decide
    post :broadcast_to_not_attended
    assert_redirected_to admin_mailers_path
    #sleep 20
    #assert_equal ActionMailer::Base.deliveries.size, 1
  end

  test "should mail broadcast" do
    post :broadcast
    assert_redirected_to admin_mailers_path
  end
  
  test "should mail broadcast to admins" do
    post :broadcast_to_admins
    assert_redirected_to admin_mailers_path
  end


end
