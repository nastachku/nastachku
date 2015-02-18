require 'test_helper'

class Web::Admin::PropagatorsControllerTest < ActionController::TestCase
  setup do
    @propagator = create :propagator
    @user = create :admin
    sign_in @user
  end

  test "should get index" do
    get :index

    assert_response :success
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should post create" do
    attrs = attributes_for :propagator

    post :create, propagator: attrs

    assert_response :redirect
    assert Propagator.find_by(title: attrs[:title])
  end

  test "should get edit" do
    get :edit, id: @propagator

    assert_response :success
  end

  test "should put update" do
    attrs = attributes_for :propagator

    put :update, id: @propagator, propagator: attrs

    @propagator.reload
    assert_response :redirect
    assert @propagator.title == attrs[:title]
  end

  test "should delete destroy" do
    count = Propagator.count
    delete :destroy, id: @propagator

    assert_response :redirect
    assert count - Propagator.count == 1
  end

end
