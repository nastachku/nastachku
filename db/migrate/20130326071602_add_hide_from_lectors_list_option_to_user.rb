class AddHideFromLectorsListOptionToUser < ActiveRecord::Migration
  def change
    add_column :users, :invisible_lector, :boolean
  end
end
