require 'test_helper'

class UserDecoratorTest < Draper::TestCase
  setup do
    @user = (create :user).decorate
  end

  test "assets user pic" do
    assert @user.assets_user_pic
  end

  test "ticket" do
    ticket = create :ticket_order
    ticket.pay
    @user.orders << ticket
    assert @user.ticket
  end

  test "ticket_price" do
    ticket = create :ticket_order
    ticket.pay
    @user.orders << ticket
    assert @user.ticket_price
  end

  test "ticket_date" do
    ticket = create :ticket_order
    ticket.pay
    @user.orders << ticket
    assert @user.ticket
  end
end
