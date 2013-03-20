class RemoveSlotColumnsFromBaseEvents < ActiveRecord::Migration
  def up
    remove_column :base_events, :start_time
    remove_column :base_events, :finish_time
    remove_column :base_events, :hall_id
  end

  def down
    add_column :base_events, :start_time, :datetime
    add_column :base_events, :finish_time, :datetime
    add_column :base_events, :hall_id, :integer
  end
end
