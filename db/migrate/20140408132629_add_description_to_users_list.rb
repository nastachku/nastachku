class AddDescriptionToUsersList < ActiveRecord::Migration
  def change
    add_column :users_lists, :description, :text
  end
end
