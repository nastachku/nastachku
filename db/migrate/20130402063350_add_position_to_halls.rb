class AddPositionToHalls < ActiveRecord::Migration
  def change
    add_column :halls, :position_sorting, :integer
  end
end
