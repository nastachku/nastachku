class AddAttendingConferenceStateEventToUser < ActiveRecord::Migration
  def change
    add_column :users, :attending_conference_state, :string
  end
end
