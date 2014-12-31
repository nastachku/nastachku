class UpdateDefaultUserTimepadState < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.where(timepad_state: nil).update_all(timepad_state: :new)
  end

  def down
    User.update_all(timepad_state: nil)
  end
end
