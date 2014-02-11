require 'test_helper'

class Web::Account::TicketOrdersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @order = create :ticket_order
  end

  test "should post create" do
    attributes = attributes_for :ticket_order
    post :create, ticket_order: attributes

    assert_response :redirect
    assert_equal attributes[:ticket_type], TicketOrder.last.ticket_type
  end
end
