class AddFromToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :from, :integer
  end
end
