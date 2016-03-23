require 'test_helper'

class Web::Admin::LecturesControllerTest < ActionController::TestCase

  setup do
    @user = create :admin
    @lecture = create :lecture
    sign_in @user
    @workshop = @lecture.workshop
  end

  test "should get index" do
    get :index
    assert_response :success
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lecture.id
    assert_response :success
  end

  test "should post create" do
    attrs = attributes_for :lecture, workshop_id: @workshop.id, user_id: @user.id
    post :create, lecture: attrs
    assert_response :redirect
    lecture = Lecture.find_by_title attrs[:title]
    assert lecture
  end

  test "should not post create" do
    attrs = attributes_for :lecture, workshop_id: @workshop.id, user_id: @user.id
    attrs[:title] = nil
    post :create, lecture: attrs
    assert_response :success
  end

  test "should put update" do
    attrs = attributes_for :lecture, workshop_id: @workshop.id, user_id: @user.id
    put :update, id: @lecture.id, lecture: attrs
    assert_response :redirect
    lecture = Lecture.find_by_title attrs[:title]
    assert lecture
  end

  test "should not put update" do
    attrs = attributes_for :lecture, workshop_id: @workshop.id, user_id: @user.id
    attrs[:title] = nil
    put :update, id: @lecture.id, lecture: attrs
    assert_response :success
  end

  test "should generate report" do
    get :report
    assert_response :success
  end
end
