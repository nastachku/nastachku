class AddIconToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :icon, :text
  end
end
