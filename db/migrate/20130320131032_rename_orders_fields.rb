class RenameOrdersFields < ActiveRecord::Migration
  def change
    rename_column :orders, :count, :items_count
    rename_column :orders, :size, :item_size
  end
end
