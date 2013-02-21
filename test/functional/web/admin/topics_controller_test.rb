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
    attrs = attributes_for :topic
    post :create, topic: attrs
    assert_response :redirect
    topic = Topic.find_by_title(attrs[:title])
    assert topic
  end

  test "should put update" do
    attrs = attributes_for :topic
    put :update, id: @topic.id, topic: attrs
    assert_response :redirect
    topic = Topic.find_by_title(attrs[:title])
    assert @topic.id == topic.id
    assert topic
  end

  test "should delete destroy" do
    delete :destroy, id: @topic.id
    assert !Topic.exists?(@topic)
  end

end
