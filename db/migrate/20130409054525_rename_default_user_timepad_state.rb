class RenameDefaultUserTimepadState < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.update_all({timepad_state: :unsynchronized}, timepad_state: :new)
  end

  def down
    User.update_all({timepad_state: :new}, timepad_state: :unsynchronized)
  end
end
