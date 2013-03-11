class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :event_id
      t.integer :hall_id
      t.datetime :start_time
      t.datetime :finish_time

      t.timestamps
    end
  end
end
