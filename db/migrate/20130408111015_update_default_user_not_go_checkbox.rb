class UpdateDefaultUserNotGoCheckbox < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.where(not_going_to_conference: nil).update_all(not_going_to_conference: false)
  end

  def down
    User.update_all(not_going_to_conference: nil)
  end
end
