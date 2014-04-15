require 'test_helper'
require "#{Rails.root}/lib/data/timepad_data_helper"

class Data::TimepadDataHelperTest < ActiveSupport::TestCase
  test "test restore_data_from_timepad_csv" do
    user = create :user
    user.email = "test@nastachku.ru"
    user.save
    other_users = Data::TimepadDataHelper.restore_data_from_timepad_csv("timepad.csv")
    assert other_users.count
  end
end
