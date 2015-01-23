require 'test_helper'

class Web::Admin::PagesControllerTest < ActionController::TestCase

  setup do
    user = create :admin

    sign_in user

    @page = create :page
  end

  test "should get index" do
    get :index

    assert_response :success
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should create page" do
    attrs = attributes_for :page

    post :create, page: attrs

    assert_response :redirect
  end

  test "should get show" do
    get :show, id: @page

    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page

    assert_response :success
  end

  test "should update page" do
    attrs = attributes_for :page

    put :update, id: @page, page: attrs

    assert_response :redirect

    page = Page.find_by_slug attrs[:slug]

    assert page
  end

  test "should destroy page" do
    delete :destroy, id: @page

    assert_response :redirect
    assert !Page.exists?(@page.id)
  end

end
