class UpdateDefaultUserNotGoCheckbox < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.update_all({not_going_to_conference: false}, not_going_to_conference: nil)
  end

  def down
    User.update_all(not_going_to_conference: nil)
  end
end
