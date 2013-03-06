class AddTimeFieldsForEvents < ActiveRecord::Migration
  def change
  	add_column :base_events, :start_time, :datetime
  	add_column :base_events, :finish_time, :datetime
  end
end
