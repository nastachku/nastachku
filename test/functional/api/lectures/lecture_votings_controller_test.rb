require 'test_helper'

class Api::Lectures::LectureVotingsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @lecture = create :lecture
  end

  test "should post :create" do
    post :create, format: :json, lecture_id: @lecture.id
    assert_response :success
    assert @lecture.lecture_votings.voted_by?(@user)
  end

  test "should delete destroy" do
    @lecture.lecture_votings.vote_by @user

    delete :destroy, format: :json, lecture_id: @lecture.id
    assert_response :success
    assert !@lecture.lecture_votings.voted_by?(@user)
  end


end