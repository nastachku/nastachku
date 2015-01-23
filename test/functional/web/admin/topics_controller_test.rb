require 'test_helper'

class Web::Admin::TopicsControllerTest < ActionController::TestCase
  setup do
    @user = create :admin
    sign_in @user
    @topic = create :topic
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
    get :edit, id: @topic.id
    assert_response :success
  end

  test "should post create" do
    attributes = attributes_for :topic
    post :create, topic: attributes
    assert_response :redirect
    assert_equal attributes[:title], Topic.last.title
  end

  test "should not post create" do
    attributes = attributes_for :topic
    attributes[:title] = nil
    post :create, topic: attributes
    assert_response :success
  end

  test "should put update" do
    attributes = attributes_for :topic
    put :update, id: @topic.id, topic: attributes
    assert_response :redirect
    @topic.reload
    assert_equal attributes[:title], @topic.title
  end

  test "should not put update" do
    attributes = attributes_for :topic
    attributes[:title] = nil
    put :update, id: @topic.id, topic: attributes
    assert_response :success
  end

  test "should delete destroy" do
    delete :destroy, id: @topic.id
    assert !Topic.exists?(@topic.id)
  end

end
