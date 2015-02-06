class DropBaseEventsTable < ActiveRecord::Migration
  def change
    drop_table :base_events
  end
end
