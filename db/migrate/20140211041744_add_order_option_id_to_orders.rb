class AddOrderOptionIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_option_id, :integer
  end
end
