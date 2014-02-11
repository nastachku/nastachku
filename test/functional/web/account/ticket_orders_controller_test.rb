require 'test_helper'

class Web::Account::TicketOrdersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
    @order = create :ticket_order
  end

<<<<<<< HEAD
=======
  test "should get new" do
    get :new
    assert_response :success
  end

>>>>>>> 940c36cc6eab2279d083dac39d5d976c4827fac5
  test "should post create" do
    attributes = attributes_for :ticket_order
    post :create, ticket_order: attributes

    assert_response :redirect
    order = current_user.orders.find_by_items_count attributes[:items_count]
    assert order
  end
end
