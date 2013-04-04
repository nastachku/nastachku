class AddDescriptionAndColorToEvent < ActiveRecord::Migration
  def change
    add_column :events, :description, :text
    add_column :events, :color, :string
  end
end
