require 'test_helper'

class Web::Admin::SpeakersControllerTest < ActionController::TestCase
  setup do
    user = create :admin
    sign_in user
    @attrs = attributes_for :speaker
    @speaker = create :speaker
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create, speaker: @attrs
    speaker = Speaker.find_by_email @attrs[:email] 
    assert speaker
    assert_response :redirect
  end

  test "should get show" do
    get :show, id: @speaker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @speaker
    assert_response :success
  end

  test "should get update" do   
    get :update, id: @speaker, speaker: @attrs
    speaker = Speaker.find_by_email @attrs[:email] 
    assert speaker
    assert_response :redirect
  end

end
