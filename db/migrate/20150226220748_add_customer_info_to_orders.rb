class AddCustomerInfoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :customer_info, :text
  end
end
