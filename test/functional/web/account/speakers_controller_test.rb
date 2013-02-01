require 'test_helper'

class Web::Account::SpeakersControllerTest < ActionController::TestCase

  setup do
    @speaker = create :speaker
    @attrs = attributes_for :speaker 
    sign_in(@speaker)
  end

  test "should get edit" do
    get :edit, id: @speaker
    assert_response :success
  end

  test "should update speaker" do
    put :update, id: @speaker, speaker: @attrs
    speaker = Speaker.find_by_email @attrs[:email] 
    assert speaker
    assert_response :redirect
  end
end
