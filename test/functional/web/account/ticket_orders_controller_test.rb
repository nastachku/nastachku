require 'test_helper'

class Web::Account::TicketOrdersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @order = create :ticket_order
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    attributes = attributes_for :ticket_order
    post :create, ticket_order: attributes

    assert_response :redirect
    order = current_user.orders.find_by_items_count attributes[:items_count]
    assert order
  end
end
