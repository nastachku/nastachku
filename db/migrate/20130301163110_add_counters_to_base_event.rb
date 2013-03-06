class AddCountersToBaseEvent < ActiveRecord::Migration
  def up
    add_column :base_events, :listener_votings_count, :integer, default: 0
    add_column :base_events, :lecture_votings_count, :integer, default: 0
  end

  def down
    remove_column :base_events, :listener_votings_count
    remove_column :base_events, :lecture_votings_count
  end
end
