require 'test_helper'

class Web::Account::TicketOrdersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @order = create :ticket_order
  end

  test "should post create" do
    tickets_count = TicketOrder.count
    attributes = attributes_for :ticket_order
    post :create, ticket_order: attributes

    assert_response :redirect
    assert_equal tickets_count + 1, TicketOrder.count
  end

  test "should not post create" do
    tickets_count = TicketOrder.count
    attributes = attributes_for :ticket_order
    attributes[:items_count] = nil
    post :create, ticket_order: attributes

    assert_response :redirect
    assert_equal tickets_count, TicketOrder.count
  end
end
