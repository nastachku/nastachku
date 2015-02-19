require 'test_helper'

class Web::Admin::DistributorsControllerTest < ActionController::TestCase
  setup do
    @distributor = create :distributor
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
    attrs = attributes_for :distributor

    post :create, distributor: attrs

    assert_response :redirect
    assert Distributor.find_by(title: attrs[:title])
  end

  test "should get edit" do
    get :edit, id: @distributor

    assert_response :success
  end

  test "should put update" do
    attrs = attributes_for :distributor

    put :update, id: @distributor, distributor: attrs

    @distributor.reload
    assert_response :redirect
    assert @distributor.title == attrs[:title]
  end

  test "should delete destroy" do
    count = Distributor.count
    delete :destroy, id: @distributor

    assert_response :redirect
    assert count - Distributor.count == 1
  end

end
