class AddWorkshopToEvent < ActiveRecord::Migration
  def change
  	add_column :base_events, :workshop_id, :integer
  end
end
