require 'test_helper'

class Web::MembersControllerTest < ActionController::TestCase

  test "should get index" do
    get :index

    assert_response :success
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should create user" do
    attrs = attributes_for :member

    post :create, member: attrs

    assert_response :redirect
    assert_equal attrs[:email], Member.last.email
  end

end
