class AddColorFieldToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :item_color, :string
  end
end
