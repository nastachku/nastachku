require 'test_helper'

class Web::Account::LecturesControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @lecture = @user.lectures.first
  end

  test "should get new" do
    get :new, user_id: @user.id
    assert_response :success
  end

  test "should post create" do
    attrs = generate(:user_with_lectures)
    post :create, user_id: @user.id, user: attrs

    assert_response :redirect
    lecture = @user.lectures.find_by_title(attrs[:lectures_attributes][1][:title])
    assert lecture
  end

  test "should put update" do
    attrs = attributes_for(:lecture)
    put :update, id: @lecture.id, lecture: attrs
    assert_response :success
    expected_lecture = @lecture.reload
    actual_lecture = Lecture.find @lecture
    assert expected_lecture.title == actual_lecture.title
  end

end