require 'test_helper'

class Web::Admin::NewsControllerTest < ActionController::TestCase

  setup do
    user = create :admin

    sign_in user

    @news = create :news
  end

  test "should get index" do
    get :index

    assert_response :success
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should create news" do
    attrs = attributes_for :news

    assert_difference 'News.count' do
      post :create, news: attrs
    end

    assert_response :redirect
    assert_equal attrs[:slug], News.last.slug
  end

  test "should get show" do
    get :show, id: @news

    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @news

    assert_response :success
  end

  test "should update news" do
    attrs = attributes_for :news

    put :update, id: @news, news: attrs

    assert_response :redirect
    assert_equal attrs[:slug], News.last.slug
  end

  test "should destroy news" do
    delete :destroy, id: @news

    assert_response :redirect
    assert !News.exists?(@news)
  end

end
