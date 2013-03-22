class UpdateDefaultOrderItemColor < ActiveRecord::Migration
  def up
    Order.reset_column_information
    Order.update_all({:item_color => :white}, :item_color => nil)
  end

  def down
    Order.update_all(:item_color => :white)
  end
end
