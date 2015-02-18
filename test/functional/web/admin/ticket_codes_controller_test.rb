require 'test_helper'

class Web::Admin::TicketCodesControllerTest < ActionController::TestCase
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
    params = attributes_for :ticket_code, propagator_id: @propagator.id
    count = TicketCode.count

    post :create, admin_ticket_code_create_type: params

    assert_response :redirect
    assert TicketCode.count - count == params[:count]
  end
end
