require 'test_helper'

class Api::Lectures::ListenerVotingsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @lecture = create :lecture
  end

  test "should post create" do
    post :create, format: :json, lecture_id: @lecture.id
    assert_response :success
    assert @lecture.listener_votings.voted_by?(@user)
  end

  test "should delete destroy" do
    @lecture.listener_votings.vote_by @user

    delete :destroy, format: :json, lecture_id: @lecture.id
    assert_response :success
    assert !@lecture.listener_votings.voted_by?(@user)
  end
end