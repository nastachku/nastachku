class AddHallToEvent < ActiveRecord::Migration
  def change
    add_column :base_events, :hall_id, :integer
  end
end
