class UpdateDefaultUserTimepadState < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.update_all({timepad_state: :new}, timepad_state: nil)
  end

  def down
    User.update_all(timepad_state: nil)
  end
end
