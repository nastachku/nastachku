class DropVotingsCountTableFromUserEvent < ActiveRecord::Migration
  def up
    remove_column :base_events, :votings_count
  end

  def down
    add_column :base_events, :votings_count, :integer
  end
end
