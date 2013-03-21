class AddColorToWorkshop < ActiveRecord::Migration
  def change
    add_column :workshops, :color, :string
  end
end
