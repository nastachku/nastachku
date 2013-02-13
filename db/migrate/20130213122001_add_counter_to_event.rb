class AddCounterToEvent < ActiveRecord::Migration
  def change
    add_column :base_events, :votings_count, :integer
  end
end
