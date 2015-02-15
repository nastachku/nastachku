class RemoveAttendingState < ActiveRecord::Migration
  def change
    remove_column :users, :attending_conference_state
  end
end
