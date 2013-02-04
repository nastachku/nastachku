require 'test_helper'

class Web::Admin::MembersControllerTest < ActionController::TestCase
  setup do
    user = create :admin
    sign_in user
    @attrs = attributes_for :member
    @member = create :member
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create, member: @attrs
    member = Member.find_by_email @attrs[:email] 
    assert member
    assert_response :redirect
  end

  test "should get show" do
    get :show, id: @member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member
    assert_response :success
  end

  test "should get update" do   
    get :update, id: @member, member: @attrs
    member = Member.find_by_email @attrs[:email] 
    assert member
    assert_response :redirect
  end

end
