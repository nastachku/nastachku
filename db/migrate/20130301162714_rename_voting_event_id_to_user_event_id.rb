class RenameVotingEventIdToUserEventId < ActiveRecord::Migration
  def change
    rename_column :votings, :event_id, :user_event_id
  end
end
