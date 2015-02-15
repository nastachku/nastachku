class DefaultValueForOrderItemsCount < ActiveRecord::Migration
  def change
    change_column_null :orders, :items_count, false, 0
    change_column_default :orders, :items_count, 0
  end
end
