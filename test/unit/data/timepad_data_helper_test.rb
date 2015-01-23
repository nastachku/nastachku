require 'test_helper'
require "#{Rails.root}/lib/data/timepad_data_helper"

class Data::TimepadDataHelperTest < ActiveSupport::TestCase
  include Data::TimepadDataHelper
  test "test restore_data_from_timepad_csv" do
    user = create :user
    user.email = "test@nastachku.ru"
    user.save
    other_users = restore_data_from_timepad_csv("timepad.csv")
    assert other_users.any?
  end

  test "test tickets_for_other_users" do
    user = create :user
    other_users = [{ id: user.id, sum: 750, pay_date: "Wed, 19 Feb 2015 16:32:44 +0000", type: I18n.t('timepad.data.ticket') }]
    tickets_for_other_users other_users
    assert User.find(other_users.first[:id]).ticket_orders.any?
  end
end
