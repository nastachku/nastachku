class RemoveTypeFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :type
  end
end
