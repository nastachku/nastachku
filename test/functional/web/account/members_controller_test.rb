require 'test_helper'

class Web::Account::MembersControllerTest < ActionController::TestCase

  setup do
    @member = create :member
    @attrs = attributes_for :member 
    sign_in(@member)
  end

  test "should get edit" do
    get :edit, id: @member
    assert_response :success
  end

  test "should update member" do
    put :update, id: @member, member: @attrs
    member = Member.find_by_email @attrs[:email] 
    assert member
    assert_response :redirect
  end
end
