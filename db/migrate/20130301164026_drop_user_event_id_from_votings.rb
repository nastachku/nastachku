class DropUserEventIdFromVotings < ActiveRecord::Migration
  def up
    remove_column :votings, :user_event_id
  end

  def down
    add_column :votings, :user_event_id, :integer
  end
end
